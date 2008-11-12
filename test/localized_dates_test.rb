require 'test/unit'
require 'mocha'

require 'active_support'
require 'localized_dates'

class LocalizedDatesTest < Test::Unit::TestCase
  FORMAT      = :foo
  TRANSLATED  = 'foo'
  STOCK       = 'bar'
  
  def test_date
    assert_localized(Date.today, Date::FORMATS) do |translations|
      translations[:date] = {:formats => {FORMAT => TRANSLATED}}
    end
  end
  
  def test_datetime
    # time.datetime.formats supersedes time.formats
    assert_localized(DateTime.now, Time::FORMATS) do |translations|
      translations[:time] = {:formats => {FORMAT => STOCK}, :datetime => {:formats => {FORMAT => TRANSLATED}}}
    end
    
    # Falls back to time.formats
    assert_localized(DateTime.now, Time::FORMATS) do |translations|
      translations[:time] = {:formats => {FORMAT => TRANSLATED}}
    end
  end
  
  def test_time
    assert_localized(Time.now, Time::FORMATS) do |translations|
      translations[:time] = {:formats => {FORMAT => TRANSLATED}}
    end
  end
  
  def test_time_with_zone
    time = ActiveSupport::TimeZone['UTC'].now
    
    # Format :db
    time.utc.expects(:to_s).with(:db).returns "result"
    assert_equal "result", time.to_s(:db)
    
    # time.time_with_zone.formats supersedes time.formats
    assert_localized(time, Time::FORMATS) do |translations|
      translations[:time] = {:formats => {FORMAT => STOCK}, :time_with_zone => {:formats => {FORMAT => TRANSLATED}}}
    end
    
    # Falls back to time.formats
    assert_localized(time, Time::FORMATS) do |translations|
      translations[:time] = {:formats => {FORMAT => TRANSLATED}}
    end
  end
  
private

  def assert_localized(object, defaults)
    # Translated format supersedes default format
    yield localized = {}
    setup_format_entries(defaults, localized) do
      I18n.expects(:localize).with(object, :format => TRANSLATED).returns "result"
      assert_equal "result", object.to_s(FORMAT)
    end
    
    # Falls back to default format
    setup_format_entries(defaults) do
      I18n.expects(:localize).with(object, :format => STOCK).returns "result"
      assert_equal "result", object.to_s(FORMAT)
    end
  end
  
  def setup_format_entries(defaults, localized={})
    # Translations
    old_translations = I18n.backend.instance_eval('@translations').dup rescue nil
    I18n.backend.store_translations(:en, localized)
    begin
      # Locale
      old_locale, I18n.locale = I18n.locale, :en
      begin
        # Defaults
        old_defaults = defaults.dup
        defaults.replace({FORMAT => STOCK})
        begin
          return yield
        ensure
          defaults.replace(old_defaults)
        end
      ensure
        I18n.locale = old_locale
      end
    ensure
      I18n.backend.instance_eval('@translations').replace(old_translations || {})
    end
  end
end