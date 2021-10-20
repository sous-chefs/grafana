#
# Cookbook:: grafana
# Resource:: plugin
#
# Copyright:: 2014, Jonathan Tron
# Copyright:: 2017, Andrei Skopenko
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

unified_mode true

property :plugin_name, String,
          name_property: true

property :grafana_cli_bin, String,
          default: '/usr/sbin/grafana-cli'

property :plugin_url, String

action_class do
  include Grafana::Cookbook::PluginHelper
end

action :install do
  directory '/var/lib/grafana/plugins' do
    recursive true
    owner 'grafana'
    group 'grafana'
    mode '0755'

    action :create
  end unless ::Dir.exist?('/var/lib/grafana/plugins')

  raise "#{new_resource.plugin_name} is not available" unless plugin_available?(new_resource.plugin_name) || new_resource.plugin_url

  converge_by("Installing plugin #{new_resource.plugin_name}") do
    plugin_action(action: :install, name: new_resource.plugin_name, plugin_url: new_resource.plugin_url)
  end unless plugin_installed?(new_resource.plugin_name)
end

action :update do
  if plugin_installed?(new_resource.plugin_name)
    converge_by("Updating plugin #{new_resource.plugin_name}") do
      plugin_action(action: :update, name: new_resource.plugin_name, plugin_url: new_resource.plugin_url)
    end if plugin_update_available?(new_resource.plugin_name)
  else
    Chef::Log.warn "Impossible to upgrade plugin #{new_resource.plugin_name} because it is not installed. We will install it."
    run_action(:install)
  end
end

action :remove do
  converge_by("Removing plugin #{name}") do
    plugin_action(action: :remove, name: new_resource.plugin_name)
  end if plugin_installed?(new_resource.plugin_name)
end
