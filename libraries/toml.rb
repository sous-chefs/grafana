require 'deepsort'
require 'toml-rb'

module Grafana
  module Cookbook
    module TomlHelper
      def load_tomlfile(file)
        return unless File.exist?(file)

        ::TomlRB.load_file(file)
      end

      def tomlfile_string(content)
        raise ArgumentError, "Expected Hash got #{content.class}" unless content.is_a?(Hash)

        ::TomlRB.dump(content.deep_sort)
      end
    end
  end
end
