require 'active_support'
require 'localized_dates'

describe "Date and Time localization" do
  describe Date do
    it "should translate format when to_s is called" do
      I18n.should_receive(:translate).with(:'date.formats', :raise => true).and_return({})
      Date.today.to_s(:custom)
    end
  end

  describe Time do
    it "should translate format when to_s is called" do
      I18n.should_receive(:translate).with(:'time.formats', :raise => true).and_return({})
      Time.now.to_s(:custom)
    end
  end

  describe DateTime do
    it "should translate format when to_s is called" do
      I18n.should_receive(:translate).with(:'time.formats', :raise => true).and_return({})
      I18n.should_receive(:translate).with(:'time.datetime.formats', :raise => true).and_return({})
      
      DateTime.now.to_s(:custom)
    end
  end

  describe ActiveSupport::TimeWithZone do
    it "should translate format when to_s is called" do
      I18n.should_receive(:translate).with(:'time.formats', :raise => true).and_return({})
      I18n.should_receive(:translate).with(:'time.time_with_zone.formats', :raise => true).and_return({})

      ActiveSupport::TimeZone['UTC'].now.to_s(:custom)
    end
  end
end
