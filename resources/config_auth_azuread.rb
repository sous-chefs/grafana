# Cookbook:: grafana
# Resource:: config_auth_azuread
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

property  :instance_name,                          String,         name_property: true
property  :auth_name,                              String,         default: 'AzureAD'
property  :enabled,                                [true, false],  default: false
property  :allow_sign_up,                          [true, false],  default: true
property  :client_id,                              String,         default: ''
property  :client_secret,                          String,         default: ''
property  :scopes,                                 String,         default: 'openid email profile'
property  :auth_url,                               String,         default: ''
property  :token_url,                              String,         default: ''
property  :allowed_domains,                        String,         default: ''
property  :allowed_groups,                         String,         default: ''

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['name'] ||= '' unless new_resource.auth_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['name'] << new_resource.auth_name.to_s unless new_resource.auth_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['enabled'] ||= '' unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allow_sign_up'] ||= '' unless new_resource.allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allow_sign_up'] << new_resource.allow_sign_up.to_s unless new_resource.allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_id'] ||= '' unless new_resource.client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_id'] << new_resource.client_id.to_s unless new_resource.client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_secret'] ||= '' unless new_resource.client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_secret'] << new_resource.client_secret.to_s unless new_resource.client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['scopes'] ||= '' unless new_resource.scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['scopes'] << new_resource.scopes.to_s unless new_resource.scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['auth_url'] ||= '' unless new_resource.auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['auth_url'] << new_resource.auth_url.to_s unless new_resource.auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['token_url'] ||= '' unless new_resource.token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['token_url'] << new_resource.token_url.to_s unless new_resource.token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_domains'] ||= '' unless new_resource.allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_domains'] << new_resource.allowed_domains.to_s unless new_resource.allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_groups'] ||= '' unless new_resource.allowed_groups.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_groups'] << new_resource.allowed_groups.to_s unless new_resource.allowed_groups.nil?
end
