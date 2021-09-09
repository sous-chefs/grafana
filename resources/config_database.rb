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

property :type, Symbol,
          default: :sqlite3,
          equal_to: %i(mysql postgres sqlite3)

property :host, String

property :database_name, String

property :user, String

property :password, String

property :url, String

property :max_idle_conn, Integer

property :max_open_conn, Integer

property :conn_max_lifetime, Integer

property :log_queries, [true, false], default: false

property :ssl_mode, [Symbol, true, false],
          default: :disable,
          equal_to: [ :disable, :require, :'verify-full', true, false, :'skip-verify' ]

property :isolation_level, String,
          equal_to: %w(READ-UNCOMMITTED READ-COMMITTED REPEATABLE-READ SERIALIZABLE)

property :ca_cert_path, String

property :client_key_path, String

property :client_cert_path, String

property :server_cert_name, String

property :path, String,
          default: 'grafana.db'

property :cache_mode, String

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp))
  end
end
