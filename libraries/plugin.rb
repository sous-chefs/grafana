# Cookbook:: grafana
# Library:: plugin
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

module Grafana
  module Cookbook
    module Plugin
      module_function

      def available?(name, grafana_cli_bin)
        cmd = Mixlib::ShellOut.new("#{grafana_cli_bin} plugins list-remote")
        cmd.run_command
        !cmd.stdout.split("\n").select { |item| item.include?('id:') && item.match(name) }.empty?
      end

      def installed?(name, grafana_cli_bin)
        cmd = Mixlib::ShellOut.new("#{grafana_cli_bin} plugins ls")
        cmd.run_command
        !cmd.stdout.split("\n").select { |item| item.include?('@') && item.match(name) }.empty?
      end

      def build_cli_cmd(name, action, grafana_cli_bin, plugin_url = nil)
        extra_args = "--pluginUrl #{plugin_url} " if plugin_url
        "#{grafana_cli_bin} #{extra_args}plugins #{action} #{name}"
      end
    end
  end
end
