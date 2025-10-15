#
# Cookbook:: grafana
# Resource:: config_database
#
# Copyright:: 2021, Sous Chefs
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

unified_mode true

use 'partial/_config_file'

property :type, [Symbol, String],
          default: :sqlite3,
          equal_to: [ :mysql, :postgres, :sqlite3, 'mysql', 'postgres', 'sqlite3' ],
          coerce: proc(&:to_s)

property :host, String

property :database_name, String

property :user, String

property :password, String

property :url, String

property :max_idle_conn, Integer

property :max_open_conn, Integer

property :conn_max_lifetime, Integer

property :log_queries, [true, false], default: false

property :ssl_mode, [String, Symbol, true, false],
          equal_to: [ 'disable', :disable, 'require', :require, 'verify-full', :'verify-full', true, false, 'skip-verify', :'skip-verify' ]

property :isolation_level, String,
          equal_to: %w(READ-UNCOMMITTED READ-COMMITTED REPEATABLE-READ SERIALIZABLE)

property :ca_cert_path, String

property :client_key_path, String

property :client_cert_path, String

property :server_cert_name, String

property :path, String,
          default: 'grafana.db'

property :cache_mode, String

def resource_config_properties_translate
  {
    database_name: 'name',
  }.freeze
end
