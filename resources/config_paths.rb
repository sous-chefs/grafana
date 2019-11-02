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
property  :data,                String, default: '/var/lib/grafana'
property  :temp_data_lifetime,  String, default: '24h'
property  :logs,                String, default: '/var/log/grafana'
property  :plugins,             String, default: '/var/lib/grafana/plugins'
property  :provisioning,        String, default: 'conf/provisioning'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['data'] ||= '' unless new_resource.data.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['data'] << new_resource.data.to_s unless new_resource.data.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['temp_data_lifetime'] ||= '' unless new_resource.temp_data_lifetime.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['temp_data_lifetime'] << new_resource.temp_data_lifetime.to_s unless new_resource.temp_data_lifetime.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['logs'] ||= '' unless new_resource.logs.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['logs'] << new_resource.logs.to_s unless new_resource.logs.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['plugins'] ||= '' unless new_resource.plugins.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['plugins'] << new_resource.plugins.to_s unless new_resource.plugins.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['provisioning'] ||= '' unless new_resource.provisioning.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['paths']['provisioning'] << new_resource.provisioning.to_s unless new_resource.provisioning.nil?
end
