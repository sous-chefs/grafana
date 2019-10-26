#
# Cookbook:: grafana
# Resource:: config_alerting
#
# Copyright:: 2019, Sous Chefs
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
# Configures the installed grafana instance's ldap settings
# See https://raw.githubusercontent.com/grafana/grafana/master/conf/ldap.toml

property  :instance_name,                 String, name_property: true
property  :log_filters,                   String
property  :servers_attributes_name,       String, default: 'givenName'
property  :servers_attributes_surname,    String, default: 'sn'
property  :servers_attributes_username,   String, default: 'cn'
property  :servers_attributes_member_of,  String, default: 'memberOf'
property  :servers_attributes_email,      String, default: 'email'

action :install do
  node.run_state['sous-chefs'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap'] ||= {}

  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['log_filters'] ||= '' unless new_resource.log_filters.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['log_filters'] << new_resource.log_filters.to_s unless new_resource.log_filters.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_name'] ||= '' unless new_resource.servers_attributes_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_name'] << new_resource.servers_attributes_name.to_s unless new_resource.servers_attributes_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_surname'] ||= '' unless new_resource.servers_attributes_surname.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_surname'] << new_resource.servers_attributes_surname.to_s unless new_resource.servers_attributes_surname.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_username'] ||= '' unless new_resource.servers_attributes_username.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_username'] << new_resource.servers_attributes_username.to_s unless new_resource.servers_attributes_username.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_member_of'] ||= '' unless new_resource.servers_attributes_member_of.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_member_of'] << new_resource.servers_attributes_member_of.to_s unless new_resource.servers_attributes_member_of.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_email'] ||= '' unless new_resource.servers_attributes_email.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers_attributes_email'] << new_resource.servers_attributes_email.to_s unless new_resource.servers_attributes_email.nil?
end
