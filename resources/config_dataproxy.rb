#
# Cookbook:: grafana
# Resource:: config_dataproxy
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

property :logging, [true, false],
          default: false

property :timeout, Integer

property :keep_alive_seconds, Integer

property :tls_handshake_timeout_seconds, Integer

property :expect_continue_timeout_seconds, Integer

property :max_conns_per_host, Integer

property :max_idle_connections, Integer

property :max_idle_connections_per_host, Integer

property :idle_conn_timeout_seconds, Integer

property :send_user_header, [true, false]

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp))
  end
end
