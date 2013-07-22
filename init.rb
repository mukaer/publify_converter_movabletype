class Converter
  def self.convert_from(engine, options = {})

    root = File.expand_path "../" , __FILE__
    require "#{root}/lib/converters/base"
    require "#{root}/lib/converters/#{engine}"
    puts    "converting #{engine.to_s.humanize}..."
    "#{engine.to_s.camelize}Converter".constantize.convert(options)    
    
  end
end
