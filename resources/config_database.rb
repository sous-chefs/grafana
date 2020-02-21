#
# Cookbook:: grafana
# Resource:: config_database
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

property  :instance_name,     String,                   name_property: true
property  :type,              Symbol,                   default: :sqlite3, equal_to: %i( mysql postgres sqlite3 )
property  :host,              String,                   default: '127.0.0.1:3306'
property  :database_name,     String,                   default: 'grafana'
property  :user,              String,                   default: 'root'
property  :password,          String,                   default: ''
property  :max_idle_conn,     Integer,                  default: 2
property  :max_open_conn,     Integer,                  default: 0
property  :conn_max_lifetime, Integer,                  default: 14400
property  :log_queries,       [true, false],            default: false
property  :ssl_mode,          [Symbol, TrueClass, FalseClass], default: :disable, equal_to: [ :disable, :require, :'verify-full', true, false, :'skip-verify' ]
property  :ca_cert_path,      String,                   default: ''
property  :client_key_path,   String,                   default: ''
property  :client_cert_path,  String,                   default: ''
property  :server_cert_name,  String,                   default: ''
property  :path,              String,                   default: 'grafana.db'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['type'] ||= '' unless new_resource.type.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['type'] << new_resource.type.to_s unless new_resource.type.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['host'] ||= '' unless new_resource.host.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['host'] << new_resource.host.to_s unless new_resource.host.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['name'] ||= '' unless new_resource.database_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['name'] << new_resource.database_name.to_s unless new_resource.database_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['user'] ||= '' unless new_resource.user.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['user'] << new_resource.user.to_s unless new_resource.user.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['password'] ||= '' unless new_resource.password.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['password'] << new_resource.password.to_s unless new_resource.password.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['max_idle_conn'] ||= '' unless new_resource.max_idle_conn.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['max_idle_conn'] << new_resource.max_idle_conn.to_s unless new_resource.max_idle_conn.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['max_open_conn'] ||= '' unless new_resource.max_open_conn.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['max_open_conn'] << new_resource.max_open_conn.to_s unless new_resource.max_open_conn.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['conn_max_lifetime'] ||= '' unless new_resource.conn_max_lifetime.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['conn_max_lifetime'] << new_resource.conn_max_lifetime.to_s unless new_resource.conn_max_lifetime.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['log_queries'] ||= '' unless new_resource.log_queries.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['log_queries'] << new_resource.log_queries.to_s unless new_resource.log_queries.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['ssl_mode'] ||= '' unless new_resource.ssl_mode.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['ssl_mode'] << new_resource.ssl_mode.to_s unless new_resource.ssl_mode.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['ca_cert_path'] ||= '' unless new_resource.ca_cert_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['ca_cert_path'] << new_resource.ca_cert_path.to_s unless new_resource.ca_cert_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['client_key_path'] ||= '' unless new_resource.client_key_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['client_key_path'] << new_resource.client_key_path.to_s unless new_resource.client_key_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['client_cert_path'] ||= '' unless new_resource.client_cert_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['client_cert_path'] << new_resource.client_cert_path.to_s unless new_resource.client_cert_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['server_cert_name'] ||= '' unless new_resource.server_cert_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['server_cert_name'] << new_resource.server_cert_name.to_s unless new_resource.server_cert_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['path'] ||= '' unless new_resource.path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['database']['path'] << new_resource.path.to_s unless new_resource.path.nil?
end
