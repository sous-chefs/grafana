#
# Cookbook:: grafana
# Resource:: config_session
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

property  :instance_name,     String,         name_property: true
# using session_provider due to: ArgumentError: Property `provider` of resource `` overwrites an existing method.
property  :session_provider,  Symbol,         default: :file, equal_to: %i( memory file redis mysql postgres memcache )
property  :provider_config,   String,         default: 'sessions'
property  :cookie_name,       String,         required: false
property  :cookie_secure,     [true, false],  default: false
property  :session_life_time, Integer,        default: 86400
property  :gc_interval_time,  Integer,        default: 86400
property  :conn_max_lifetime, Integer,        default: 14400

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp))
  end
end
