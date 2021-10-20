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
    module PluginHelper
      private

      def plugin_available?(name)
        grafana_plugins_list_remote.keys.include?(name)
      end

      def plugin_installed?(name)
        grafana_plugins_list_installed.keys.include?(name)
      end

      def plugin_update_available?(name)
        grafana_plugins_list_remote.fetch(name) > grafana_plugins_list_installed.fetch(name)
      rescue KeyError
        nil
      end

      def plugin_action(action:, name: nil, plugin_url: nil, allow_failure: false)
        raise "Invalid action [#{action.class}] #{action}" unless %i(install update upgrade remove list-remote ls).include?(action)

        plugin_cmd = new_resource.grafana_cli_bin.dup
        plugin_cmd.concat(" --pluginUrl #{plugin_url}") if plugin_url
        plugin_cmd.concat(" plugins #{action}")
        plugin_cmd.concat(" #{name}") if name
        Chef::Log.debug("Plugin command: #{plugin_cmd}")

        plugin_cmd = Mixlib::ShellOut.new(plugin_cmd)
        plugin_cmd.run_command
        plugin_cmd.error! unless allow_failure

        plugin_cmd.stdout
      end

      def grafana_plugins_list_remote
        plugins = plugin_action(action: :'list-remote').split("\n").select { |i| i.include?('id:') }.map { |i| i.delete_prefix('id: ') }
        plugins.map! { |p| p.split('version:').map(&:strip) }
        Chef::Log.debug("Remote available plugins: #{plugins.to_h}")

        plugins.to_h
      end

      def grafana_plugins_list_installed
        plugins = plugin_action(action: :ls).split("\n").select { |i| i.include?('@') }
        plugins.map! { |p| p.split('@').map(&:strip) }
        Chef::Log.debug("Installed plugins: #{plugins.to_h}")

        plugins.to_h
      end
    end
  end
end
