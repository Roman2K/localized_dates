class DateTime < Date
  def to_formatted_s(format=:default)
    translated = begin
      default_formatters = I18n.translate(:'time.formats', :raise => true) rescue {}
      twz_formatters = I18n.translate(:'time.datetime.formats', :raise => true) rescue {}
      default_formatters.merge(twz_formatters)[format]
    end
    format = translated || Time::FORMATS[format]
    format = format.call(self) if format.respond_to? :call
    
    I18n.localize(self, :format => format)
  end
  alias_method :to_s, :to_formatted_s
end
