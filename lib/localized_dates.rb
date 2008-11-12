class Date
  FORMATS = ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS
  
  def to_formatted_s(format=:default)
    format = (I18n.translate(:'date.formats', :raise => true) rescue {})[format] || FORMATS[format]
    format = format.call(self) if format.respond_to? :call
    I18n.localize(self, :format => format)
  end
  alias_method :to_s, :to_formatted_s
end

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

class Time
  FORMATS = ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS
  
  def to_formatted_s(format=:default)
    format = (I18n.translate(:'time.formats', :raise => true) rescue {})[format] || FORMATS[format]
    format = format.call(self) if format.respond_to? :call
    I18n.localize(self, :format => format)
  end
  alias_method :to_s, :to_formatted_s
end

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
