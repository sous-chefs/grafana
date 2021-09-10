# Cookbook:: grafana
# Library:: ini
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
require 'inifile'

module Grafana
  module Cookbook
    module IniHelper
      private

      def load_inifile(file)
        return unless File.exist?(file)

        ::IniFile.load(file).to_h
      end

      def inifile_string(content)
        raise ArgumentError, "Expected Hash got #{content.class}" unless content.is_a?(Hash)

        ::IniFile.new(content: content).to_s.gsub("[global]\n", '')
      end
    end
  end
end
