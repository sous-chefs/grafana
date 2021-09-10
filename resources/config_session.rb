#
# Cookbook:: grafana
# Resource:: config_session
#
# Copyright:: 2021, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
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

property :session_provider, [String, Symbol],
          default: :file,
          equal_to: [:memory, :file, :redis, :mysql, :postgres, :memcache, 'memory', 'file', 'redis', 'mysql', 'postgres', 'memcache'],
          coerce: proc { |p| p.to_s }

property :provider_config, String,
          default: 'sessions'

property :cookie_name, String

property :cookie_secure, [true, false]

property :session_life_time, Integer

property :gc_interval_time, Integer

property :conn_max_lifetime, Integer

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp))
  end
end
