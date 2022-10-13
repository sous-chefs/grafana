# Cookbook:: grafana
# Library:: toml
#
# Copyright:: 2021, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'deepsort'
require 'toml-rb'

module Grafana
  module Cookbook
    module TomlHelper
      private

      # Load an toml file from disk
      #
      # @param file [String] The file to load
      # @return [Hash] File contents
      #
      def load_tomlfile(file)
        return unless File.exist?(file)

        ::TomlRB.load_file(file)
      end

      # Create a toml file output as a String from a Hash
      #
      # @param content [Hash] The file contents as a Hash
      # @return [String] Formatted toml output
      #
      def tomlfile_string(content, deep_sort: false)
        raise ArgumentError, "Expected Hash got #{content.class}" unless content.is_a?(Hash)

        file_content = content
        file_content.deep_sort! if deep_sort

        ::TomlRB.dump(file_content)
      end
    end
  end
end
