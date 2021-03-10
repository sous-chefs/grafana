# Cookbook:: grafana
# Resource:: config_auth_okta
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
# Configures Okta auth for installed grafana instance

property  :instance_name,        String,         name_property: true
property  :auth_name,            String,         default: 'Okta'
property  :enabled,              [true, false],  default: false
property  :allow_sign_up,        [true, false],  default: true
property  :client_id,            String,         default: ''
property  :client_secret,        String,         default: ''
property  :scopes,               Array,          default: '', description: 'openid profile email groups'
property  :auth_url,             String,         default: '', description: 'https://<tenant-id>.okta.com/oauth2/v1/authorize'
property  :token_url,            String,         default: '', description: 'https://<tenant-id>.okta.com/oauth2/v1/token'
property  :api_url,              String,         default: '', description: 'https://<tenant-id>.okta.com/oauth2/v1/userinfo'
property  :allowed_domains,      String,         default: ''
property  :allowed_groups,       String,         default: ''
property  :hosted_domain,        String,         default: ''
property  :role_attribute_path,  String,         default: ''

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['enabled'] ||= '' unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['allow_sign_up'] ||= '' unless new_resource.allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['allow_sign_up'] << new_resource.allow_sign_up.to_s unless new_resource.allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['client_id'] ||= '' unless new_resource.client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['client_id'] << new_resource.client_id.to_s unless new_resource.client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['client_secret'] ||= '' unless new_resource.client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['client_secret'] << new_resource.client_secret.to_s unless new_resource.client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['scopes'] ||= [] unless new_resource.scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['scopes'] << new_resource.scopes.to_s unless new_resource.scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['auth_url'] ||= '' unless new_resource.auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['auth_url'] << new_resource.auth_url.to_s unless new_resource.auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['token_url'] ||= '' unless new_resource.token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['token_url'] << new_resource.token_url.to_s unless new_resource.token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['api_url'] ||= '' unless new_resource.api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['api_url'] << new_resource.api_url.to_s unless new_resource.api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['allowed_domains'] ||= '' unless new_resource.allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['allowed_domains'] << new_resource.allowed_domains.to_s unless new_resource.allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['role_attribute_path'] ||= '' unless new_resource.role_attribute_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['role_attribute_path'] << new_resource.role_attribute_path.to_s unless new_resource.role_attribute_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['allowed_groups'] ||= '' unless new_resource.allowed_groups.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_okta']['allowed_groups'] << new_resource.allowed_groups.to_s unless new_resource.allowed_groups.nil?
end
