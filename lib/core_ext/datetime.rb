class DateTime < Date
  def to_formatted_s(format=:default)
    formatter = Time::DATE_FORMATS.fetch(format) do
      default_formatters = I18n.translate(:'time.formats', :raise => true) rescue {}
      datetime_formatters = I18n.translate(:'time.datetime.formats', :raise => true) rescue {}
      default_formatters.merge(datetime_formatters)[format]
    end
    format_to_localize = formatter.respond_to?(:call) ? formatter.call(self) : formatter
    
    I18n.localize(self, :format => format_to_localize)
  end
  alias_method :to_s, :to_formatted_s
end
