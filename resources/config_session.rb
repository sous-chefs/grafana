#
# Cookbook:: grafana
# Resource:: config_session
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

property  :instance_name,     String,         name_property: true
# using session_provider due to: ArgumentError: Property `provider` of resource `` overwrites an existing method.
property  :session_provider,  Symbol,         default: :file, equal_to: %i( memory file redis mysql postgres memcache )
property  :provider_config,   String,         default: 'sessions'
property  :cookie_name,       String,         required: false
property  :cookie_secure,     [true, false],  default: false
property  :session_life_time, Integer,        default: 86400
property  :gc_interval_time,  Integer,        default: 86400
property  :conn_max_lifetime, Integer,        default: 14400

action :install do
  cookie_name = new_resource.cookie_name || GrafanaCookbook::CookieHelper.cookie_name
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['provider'] ||= '' unless new_resource.session_provider.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['provider'] << new_resource.session_provider.to_s unless new_resource.session_provider.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['provider_config'] ||= '' unless new_resource.provider_config.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['provider_config'] << new_resource.provider_config.to_s unless new_resource.provider_config.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['cookie_name'] ||= '' unless cookie_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['cookie_name'] << cookie_name.to_s unless cookie_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['cookie_secure'] ||= '' unless new_resource.cookie_secure.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['cookie_secure'] << new_resource.cookie_secure.to_s unless new_resource.cookie_secure.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['session_life_time'] ||= '' unless new_resource.session_life_time.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['session_life_time'] << new_resource.session_life_time.to_s unless new_resource.session_life_time.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['gc_interval_time'] ||= '' unless new_resource.gc_interval_time.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['gc_interval_time'] << new_resource.gc_interval_time.to_s unless new_resource.gc_interval_time.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['conn_max_lifetime'] ||= '' unless new_resource.conn_max_lifetime.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['session']['conn_max_lifetime'] << new_resource.conn_max_lifetime.to_s unless new_resource.conn_max_lifetime.nil?
end
