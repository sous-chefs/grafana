module GrafanaCookbook
  module IniHelper
    def self.format_config(config)
      output = []
      case config
      when Hash
        config.each do |section, groups|
          output << format_section(section)
          groups.each do |key, value|
            output << format_kv(key, value)
          end
        end
      else
        config.each do |groups|
          output << format_section('[servers.group_mappings]')
          groups.each do |key, value|
            output << format_kv(key, value)
          end
        end
      end
      output.join "\n"
    end

    def self.format_section(section)
      "\n[#{section}]" if section
    end

    def self.format_kv(key, value)
      case value
      when Hash
        line = ''
        line << '# ' + value['comment'] + "\n" if value['comment']
        line << ';' if value['disable']
        line << "#{key} = #{value['value']}"
      else
        "#{key} = #{value}"
      end
    end
  end
end
