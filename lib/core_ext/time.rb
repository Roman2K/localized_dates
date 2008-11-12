class Time
  FORMATS = ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS
  
  def to_formatted_s(format=:default)
    formatter = FORMATS.fetch(format) do
      (I18n.translate(:'time.formats', :raise => true) rescue {})[format]
    end
    format_to_localize = formatter.respond_to?(:call) ? formatter.call(self) : formatter
    
    I18n.localize(self, :format => format_to_localize)
  end
  alias_method :to_s, :to_formatted_s
end
