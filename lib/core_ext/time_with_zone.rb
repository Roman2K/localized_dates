class ActiveSupport::TimeWithZone
  def to_s(format=:default)
    return utc.to_s(format) if format == :db
    
    translated = begin
      default_formatters = I18n.translate(:'time.formats', :raise => true) rescue {}
      twz_formatters = I18n.translate(:'time.time_with_zone.formats', :raise => true) rescue {}
      default_formatters.merge(twz_formatters)[format]
    end
    format = translated || Time::FORMATS[format]
    format = format.call(self) if format.respond_to? :call
    
    I18n.localize(self, :format => format)
  end
end
