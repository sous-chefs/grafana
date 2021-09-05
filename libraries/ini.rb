require 'deepsort'
require 'inifile'

module Grafana
  module Cookbook
    module IniHelper
      private

      def load_inifile(file)
        return unless File.exist?(file)

        ::Inifile.load(file)
      end

      def inifile_string(content)
        raise ArgumentError, "Expected Hash got #{content.class}" unless content.is_a?(Hash)

        ::IniFile.new(content: content).to_s.gsub("[global]\n", '')
      end
    end
  end
end
