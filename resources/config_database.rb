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

unified_mode true

use 'partial/_config_file'

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

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp))
  end
end
