# Cookbook:: grafana
# Library:: grafana_config_file
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

require_relative '_utils'
require_relative 'ini'

module Grafana
  module Cookbook
    module GrafanaConfigFile
      include Grafana::Cookbook::IniHelper
      include Grafana::Cookbook::Utils

      private

      def load_file_grafana_config(config_file)
        return unless ::File.exist?(config_file)

        load_inifile(config_file)
      end

      def load_file_grafana_config_section(config_file, *section_override)
        grafana_config = load_file_grafana_config(config_file)
        section = nil_or_empty?(section_override) ? resource_default_config_path : section_override

        return if nil_or_empty?(grafana_config)

        section_config = grafana_config.dig(*section)
        Chef::Log.debug("load_file_grafana_config_section: #{config_file} section #{section.join('|')} - [#{section_config.class}] #{section_config}")

        section_config
      end
    end
  end
end
