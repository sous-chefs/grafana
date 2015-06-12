module GrafanaCookbook
  module IniHelper
    def self.format_section(section)
      "[#{section}]" if section
    end

    def self.format_value(value)
      case value
      when Hash
        line = ''
        line << '# ' + value['comment'] + "\n" if value['comment']
        line << ';' if value['disable']
        line << value['value']
      else
        value
      end
    end
  end
end
