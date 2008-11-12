class Date
  FORMATS = ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS
  
  def to_formatted_s(format=:default)
    format = (I18n.translate(:'date.formats', :raise => true) rescue {})[format] || FORMATS[format]
    format = format.call(self) if format.respond_to? :call
    I18n.localize(self, :format => format)
  end
  alias_method :to_s, :to_formatted_s
end
