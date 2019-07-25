#
# Cookbook:: grafana
# Resource:: plugin
#
# Copyright:: 2014, Jonathan Tron
# Copyright:: 2017, Andrei Skopenko
# Copyright:: 2018, Sous Chefs
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

property :grafana_cli_bin, String, default: '/usr/sbin/grafana-cli'

default_action :install

action :install do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  raise "#{plugin_name} is not available" unless ::GrafanaCookbook::Plugin.available?(plugin_name, binary)
  service 'grafana-server'
  execute "Installing plugin #{plugin_name}" do
    command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'install', binary)
    not_if { GrafanaCookbook::Plugin.installed?(new_resource.name, new_resource.grafana_cli_bin) }
    notifies :restart, 'service[grafana-server]'
  end
end

action :update do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  if GrafanaCookbook::Plugin.installed?(new_resource.name, new_resource.grafana_cli_bin)
    service 'grafana-server'
    execute "Updating plugin #{plugin_name}" do
      command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'update', binary)
      notifies :restart, 'service[grafana-server]'
    end
  else
    Chef::Log.warn "Impossible to upgrade plugin #{plugin_name} because it is not installed. We will install it."
    run_action(:install)
  end
end

action :remove do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  service 'grafana-server'
  execute "Removing plugin #{name}" do
    command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'remove', binary)
    only_if { GrafanaCookbook::Plugin.installed?(new_resource.name, new_resource.grafana_cli_bin) }
    notifies :restart, 'service[grafana-server]'
  end
end
