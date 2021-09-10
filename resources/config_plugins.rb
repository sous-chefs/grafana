#
# Cookbook:: grafana
# Resource:: config_plugins
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
# Configures the [plugins] section of the grafana config file

unified_mode true

use 'partial/_config_file'

property :enable_alpha, [true, false]

property :allow_loading_unsigned_plugins, [Array, String],
          coerce: proc { |p| Array(p).join(',') }

property :plugin_admin_enabled, [true, false]

property :plugin_admin_external_manage_enabled, [true, false]

property :plugin_catalog_url, String

action_class do
  include Grafana::Cookbook::ConfigHelper
end
