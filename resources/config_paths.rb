#
# Cookbook:: grafana
# Resource:: config_paths
#
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

property  :instance_name,       String, name_property: true
property  :conf_directory,      String, default: '/etc/grafana'
property  :config_file,         String, default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :data,                String, default: '/var/lib/grafana'
property  :temp_data_lifetime,  String, default: '24h'
property  :logs,                String, default: '/var/log/grafana'
property  :plugins,             String, default: '/var/lib/grafana/plugins'
property  :provisioning,        String, default: 'conf/provisioning'
property  :cookbook,            String, default: 'grafana'
property  :source,              String, default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['paths'] ||= {}
      variables['grafana']['paths']['data'] ||= '' unless new_resource.data.nil?
      variables['grafana']['paths']['data'] << new_resource.data.to_s unless new_resource.data.nil?
      variables['grafana']['paths']['temp_data_lifetime'] ||= '' unless new_resource.temp_data_lifetime.nil?
      variables['grafana']['paths']['temp_data_lifetime'] << new_resource.temp_data_lifetime.to_s unless new_resource.temp_data_lifetime.nil?
      variables['grafana']['paths']['logs'] ||= '' unless new_resource.logs.nil?
      variables['grafana']['paths']['logs'] << new_resource.logs.to_s unless new_resource.logs.nil?
      variables['grafana']['paths']['plugins'] ||= '' unless new_resource.plugins.nil?
      variables['grafana']['paths']['plugins'] << new_resource.plugins.to_s unless new_resource.plugins.nil?
      variables['grafana']['paths']['provisioning'] ||= '' unless new_resource.provisioning.nil?
      variables['grafana']['paths']['provisioning'] << new_resource.provisioning.to_s unless new_resource.provisioning.nil?

      action :nothing
      delayed_action :create
    end
  end
end
