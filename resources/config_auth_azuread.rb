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

property  :instance_name,                                  String,         name_property: true
property  :azuread_name,                                   String,         default: 'AzureAD'
property  :azuread_enabled,                                [true, false],  default: false
property  :azuread_allow_sign_up,                          [true, false],  default: true
property  :azuread_client_id,                              String,         default: ''
property  :azuread_client_secret,                          String,         default: ''
property  :azuread_scopes,                                 String,         default: 'openid email profile'
property  :azuread_auth_url,                               String,         default: ''
property  :azuread_token_url,                              String,         default: ''
property  :azuread_allowed_domains,                        String,         default: ''
property  :azuread_allowed_groups,                         String,         default: ''

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['name'] ||= '' unless new_resource.azuread_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['name'] << new_resource.azuread_name.to_s unless new_resource.azuread_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['enabled'] ||= '' unless new_resource.azuread_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['enabled'] << new_resource.azuread_enabled.to_s unless new_resource.azuread_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allow_sign_up'] ||= '' unless new_resource.azuread_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allow_sign_up'] << new_resource.azuread_allow_sign_up.to_s unless new_resource.azuread_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_id'] ||= '' unless new_resource.azuread_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_id'] << new_resource.azuread_client_id.to_s unless new_resource.azuread_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_secret'] ||= '' unless new_resource.azuread_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['client_secret'] << new_resource.azuread_client_secret.to_s unless new_resource.azuread_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['scopes'] ||= '' unless new_resource.azuread_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['scopes'] << new_resource.azuread_scopes.to_s unless new_resource.azuread_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['auth_url'] ||= '' unless new_resource.azuread_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['auth_url'] << new_resource.azuread_auth_url.to_s unless new_resource.azuread_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['token_url'] ||= '' unless new_resource.azuread_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['token_url'] << new_resource.azuread_token_url.to_s unless new_resource.azuread_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_domains'] ||= '' unless new_resource.azuread_allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_domains'] << new_resource.azuread_allowed_domains.to_s unless new_resource.azuread_allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_groups'] ||= '' unless new_resource.azuread_allowed_groups.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_azuread']['allowed_groups'] << new_resource.azuread_allowed_groups.to_s unless new_resource.azuread_allowed_groups.nil?
end
