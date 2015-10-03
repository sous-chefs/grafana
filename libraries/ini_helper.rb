module GrafanaCookbook
  module IniHelper
    def self.format_config(config)
      output = []
      config.each do |section, groups|
        output << config_iterator(section, groups)
      end
      output.join "\n"
    end

    def self.config_iterator(section, groups)
      output = []
      if groups.is_a?(Array)
        groups.each do |grp|
          output << config_iterator(section, grp)
        end
      else
        output << format_section(section)
        groups.each do |key, value|
          output << format_kv(key, value)
        end
      end
      output
    end

    def self.format_section(section)
      "\n[#{section}]" if section
    end

    def self.format_kv(key, value)
      case value
      when Hash
        line = ''
        line << '## ' + value['comment'] + "\n" if value['comment']
        line << '# ' if value['disable']
        line << "#{key} = #{value['value']}"
      else
        "#{key} = #{value}"
      end
    end
  end
end
