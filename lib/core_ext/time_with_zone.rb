class ActiveSupport::TimeWithZone
  def to_s(format=:default)
    return utc.to_s(format) if format == :db
    
    formatter = Time::FORMATS.fetch(format) do
      default_formatters = I18n.translate(:'time.formats', :raise => true) rescue {}
      twz_formatters = I18n.translate(:'time.time_with_zone.formats', :raise => true) rescue {}
      default_formatters.merge(twz_formatters)[format]
    end
    format_to_localize = formatter.respond_to?(:call) ? formatter.call(self) : formatter
    
    I18n.localize(self, :format => format_to_localize)
  end
end
