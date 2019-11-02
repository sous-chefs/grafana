#
# Cookbook:: grafana
# Resource:: config_metrics
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

property  :instance_name,       String,         name_property: true
property  :enabled,             [true, false],  default: true
property  :interval_seconds,    Integer,        default: 10
property  :basic_auth_username, String,         default: ''
property  :basic_auth_password, String,         default: ''
property  :graphite_address,    String,         default: ''
property  :graphite_prefix,     String,         default: 'prod.grafana.%(instance_name)s.'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['enabled'] ||= '' unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['interval_seconds'] ||= '' unless new_resource.interval_seconds.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['interval_seconds'] << new_resource.interval_seconds.to_s unless new_resource.interval_seconds.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['basic_auth_username'] ||= '' unless new_resource.basic_auth_username.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['basic_auth_username'] << new_resource.basic_auth_username.to_s unless new_resource.basic_auth_username.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['basic_auth_password'] ||= '' unless new_resource.basic_auth_password.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics']['basic_auth_password'] << new_resource.basic_auth_password.to_s unless new_resource.basic_auth_password.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics_graphite'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics_graphite']['address'] ||= '' unless new_resource.graphite_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics_graphite']['address'] << new_resource.graphite_address.to_s unless new_resource.graphite_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics_graphite']['prefix'] ||= '' unless new_resource.graphite_prefix.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['metrics_graphite']['prefix'] << new_resource.graphite_prefix.to_s unless new_resource.graphite_prefix.nil?
end
