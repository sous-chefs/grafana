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
# Configures the installed grafana instance's ldap servers
# See https://raw.githubusercontent.com/grafana/grafana/master/conf/ldap.toml
# Expects config_ldap to have been called before this

property  :instance_name,                       String,                   name_property: true
property  :host,                                String,                   required: true
property  :port,                                Integer,                  default: 389
property  :use_ssl,                             [true, false],            default: false
property  :start_tls,                           [true, false],            default: false
property  :ssl_skip_verify,                     [true, false],            default: false
property  :root_ca_cert,                        String
property  :client_cert,                         String
property  :client_key,                          String
property  :bind_dn,                             String,                   default: 'cn=admin,dc=grafana,dc=org'
property  :bind_password,                       String,                   default: 'grafana', sensitive: true
property  :search_filter,                       String,                   default: '(cn=%s)'
property  :search_base_dns,                     Array,                    default: []
property  :group_search_base_dns,               Array,                    default: []
property  :group_search_filter,                 String
property  :group_search_filter_user_attribute,  String

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['port'] ||= '' unless new_resource.port.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['port'] << new_resource.port.to_s unless new_resource.port.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['use_ssl'] ||= '' unless new_resource.use_ssl.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['use_ssl'] << new_resource.use_ssl.to_s
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['start_tls'] ||= '' unless new_resource.start_tls.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['start_tls'] << new_resource.start_tls.to_s
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['ssl_skip_verify'] ||= '' unless new_resource.ssl_skip_verify.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['ssl_skip_verify'] << new_resource.ssl_skip_verify.to_s
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['root_ca_cert'] ||= '' unless new_resource.root_ca_cert.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['root_ca_cert'] << new_resource.root_ca_cert.to_s unless new_resource.root_ca_cert.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['client_cert'] ||= '' unless new_resource.client_cert.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['client_cert'] << new_resource.client_cert.to_s unless new_resource.client_cert.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['client_key'] ||= '' unless new_resource.client_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['client_key'] << new_resource.client_key.to_s unless new_resource.client_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['bind_dn'] ||= '' unless new_resource.bind_dn.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['bind_dn'] << new_resource.bind_dn.to_s unless new_resource.bind_dn.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['bind_password'] ||= '' unless new_resource.bind_password.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['bind_password'] << new_resource.bind_password.to_s unless new_resource.bind_password.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['search_filter'] ||= '' unless new_resource.search_filter.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['search_filter'] << new_resource.search_filter.to_s unless new_resource.search_filter.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['search_base_dns'] ||= [] unless new_resource.search_base_dns.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['search_base_dns'] = new_resource.search_base_dns unless new_resource.search_base_dns.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['group_search_filter'] ||= '' unless new_resource.group_search_filter.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['group_search_filter'] << new_resource.group_search_filter.to_s unless new_resource.group_search_filter.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['group_search_base_dns'] ||= '' unless new_resource.group_search_base_dns.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['group_search_base_dns'] = new_resource.group_search_base_dns.to_s unless new_resource.group_search_base_dns.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['group_search_filter_user_attribute'] ||= '' unless new_resource.group_search_filter_user_attribute.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['servers'][new_resource.host]['group_search_filter_user_attribute'] << new_resource.group_search_filter_user_attribute.to_s unless new_resource.group_search_filter_user_attribute.nil?
end
