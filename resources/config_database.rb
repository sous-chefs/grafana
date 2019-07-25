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

property  :instance_name,     String,         name_property: true
property  :conf_directory,    String,         default: '/etc/grafana'
property  :config_file,       String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :type,              String,         default: 'sqlite3', equal_to: %w(mysql postgres sqlite3)
property  :host,              String,         default: '127.0.0.1:3306'
property  :database_name,     String,         default: 'grafana'
property  :user,              String,         default: 'root'
property  :password,          String,         default: ''
property  :max_idle_conn,     Integer,        default: 2
property  :max_open_conn,     Integer,        default: 0
property  :conn_max_lifetime, Integer,        default: 14400
property  :log_queries,       [true, false],  default: false
property  :ssl_mode,          String,         default: 'disable', equal_to: %w(disable require verify-full true false skip-verify)
property  :ca_cert_path,      String,         default: ''
property  :client_key_path,   String,         default: ''
property  :client_cert_path,  String,         default: ''
property  :server_cert_name,  String,         default: ''
property  :path,              String,         default: 'grafana.db'
property  :cookbook,          String,         default: 'grafana'
property  :source,            String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['database'] ||= {}
      variables['grafana']['database']['type'] ||= '' unless new_resource.type.nil?
      variables['grafana']['database']['type'] << new_resource.type.to_s unless new_resource.type.nil?
      variables['grafana']['database']['host'] ||= '' unless new_resource.host.nil?
      variables['grafana']['database']['host'] << new_resource.host.to_s unless new_resource.host.nil?
      variables['grafana']['database']['name'] ||= '' unless new_resource.database_name.nil?
      variables['grafana']['database']['name'] << new_resource.database_name.to_s unless new_resource.database_name.nil?
      variables['grafana']['database']['user'] ||= '' unless new_resource.user.nil?
      variables['grafana']['database']['user'] << new_resource.user.to_s unless new_resource.user.nil?
      variables['grafana']['database']['password'] ||= '' unless new_resource.password.nil?
      variables['grafana']['database']['password'] << new_resource.password.to_s unless new_resource.password.nil?
      variables['grafana']['database']['max_idle_conn'] ||= '' unless new_resource.max_idle_conn.nil?
      variables['grafana']['database']['max_idle_conn'] << new_resource.max_idle_conn.to_s unless new_resource.max_idle_conn.nil?
      variables['grafana']['database']['max_open_conn'] ||= '' unless new_resource.max_open_conn.nil?
      variables['grafana']['database']['max_open_conn'] << new_resource.max_open_conn.to_s unless new_resource.max_open_conn.nil?
      variables['grafana']['database']['conn_max_lifetime'] ||= '' unless new_resource.conn_max_lifetime.nil?
      variables['grafana']['database']['conn_max_lifetime'] << new_resource.conn_max_lifetime.to_s unless new_resource.conn_max_lifetime.nil?
      variables['grafana']['database']['log_queries'] ||= '' unless new_resource.log_queries.nil?
      variables['grafana']['database']['log_queries'] << new_resource.log_queries.to_s unless new_resource.log_queries.nil?
      variables['grafana']['database']['ssl_mode'] ||= '' unless new_resource.ssl_mode.nil?
      variables['grafana']['database']['ssl_mode'] << new_resource.ssl_mode.to_s unless new_resource.ssl_mode.nil?
      variables['grafana']['database']['ca_cert_path'] ||= '' unless new_resource.ca_cert_path.nil?
      variables['grafana']['database']['ca_cert_path'] << new_resource.ca_cert_path.to_s unless new_resource.ca_cert_path.nil?
      variables['grafana']['database']['client_key_path'] ||= '' unless new_resource.client_key_path.nil?
      variables['grafana']['database']['client_key_path'] << new_resource.client_key_path.to_s unless new_resource.client_key_path.nil?
      variables['grafana']['database']['client_cert_path'] ||= '' unless new_resource.client_cert_path.nil?
      variables['grafana']['database']['client_cert_path'] << new_resource.client_cert_path.to_s unless new_resource.client_cert_path.nil?
      variables['grafana']['database']['server_cert_name'] ||= '' unless new_resource.server_cert_name.nil?
      variables['grafana']['database']['server_cert_name'] << new_resource.server_cert_name.to_s unless new_resource.server_cert_name.nil?
      variables['grafana']['database']['path'] ||= '' unless new_resource.path.nil?
      variables['grafana']['database']['path'] << new_resource.path.to_s unless new_resource.path.nil?

      action :nothing
      delayed_action :create
    end
  end
end
