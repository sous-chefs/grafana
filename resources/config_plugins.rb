#
# Cookbook:: grafana
# Resource:: config_plugins
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

property  :instance_name,                         String,         name_property: true
property  :enable_alpha,                          [true, false],  default: false
property  :allow_loading_unsigned_plugins,        String,         default: ''
property  :plugin_admin_enabled,                  [true, false],  default: true
property  :plugin_admin_external_manage_enabled,  [true, false],  default: false
property  :plugin_catalog_url,                    String,         default: 'https://grafana.com/grafana/plugins/'
property  :plugin_catalog_hidden_plugins,         String,         default: ''

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['enable_alpha'] ||= '' unless new_resource.enable_alpha.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['enable_alpha'] << new_resource.enable_alpha.to_s unless new_resource.enable_alpha.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['allow_loading_unsigned_plugins'] ||= '' unless new_resource.allow_loading_unsigned_plugins.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['allow_loading_unsigned_plugins'] << new_resource.allow_loading_unsigned_plugins.to_s unless new_resource.allow_loading_unsigned_plugins.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_admin_enabled'] ||= '' unless new_resource.plugin_admin_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_admin_enabled'] << new_resource.plugin_admin_enabled.to_s unless new_resource.plugin_admin_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_admin_external_manage_enabled'] ||= '' unless new_resource.plugin_admin_external_manage_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_admin_external_manage_enabled'] << new_resource.plugin_admin_external_manage_enabled.to_s unless new_resource.plugin_admin_external_manage_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_catalog_url'] ||= '' unless new_resource.plugin_catalog_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_catalog_url'] << new_resource.plugin_catalog_url.to_s unless new_resource.plugin_catalog_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_catalog_hidden_plugins'] ||= '' unless new_resource.plugin_catalog_hidden_plugins.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['plugins']['plugin_catalog_hidden_plugins'] << new_resource.plugin_catalog_hidden_plugins.to_s unless new_resource.plugin_catalog_hidden_plugins.nil?
end
