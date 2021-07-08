#
# Cookbook:: grafana
# Resource:: config
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
#
# Configures the installed grafana instance

unified_mode true

use 'partial/_config_file'

property  :instance_name,       String,                   name_property: true
property  :env_directory,       String,                   default: '/etc/default'
property  :restart_on_upgrade,  [true, false],            default: false
property  :conf_directory,      String,                   default: '/etc/grafana'
property  :app_mode,            String,                   default: 'production', equal_to: %w(production development)
property  :extra_options,       Hash

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  directory new_resource.conf_directory do
    owner new_resource.owner
    group new_resource.group
    mode  '0750'
  end

  directory "/usr/share/#{new_resource.owner}" do
    owner     new_resource.owner
    group     new_resource.group
    mode      '0750'
    recursive true
  end

  template ::File.join(new_resource.env_directory, 'grafana-server') do
    source new_resource.source_env
    cookbook new_resource.cookbook
    variables(
      grafana_user: new_resource.owner,
      grafana_group: new_resource.group,
      grafana_home: "/usr/share/#{new_resource.owner}",
      conf_dir: new_resource.conf_directory,
      pid_dir: '/var/run/grafana',
      restart_on_upgrade: new_resource.restart_on_upgrade.to_s
    )
    mode '0644'
  end

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp))
  end
end
