#
# Cookbook:: grafana
# Resource:: config_unified_alerting
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

property :admin_config_poll_interval_seconds, Integer
# It is enabled by default on Grafana >=9.0: https://grafana.com/docs/grafana/v9.0/alerting/migrating-alerts/opt-out/.
property :enabled, [true, false], default: true

def resource_config_path_override
  %w(unified_alerting)
end
