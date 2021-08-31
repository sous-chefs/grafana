#
# Cookbook:: grafana
# Resource:: config_quota
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

property :enabled, [true, false],
          default: false

property :org_user, Integer

property :org_dashboard, Integer

property :org_data_source, Integer

property :org_api_key, Integer

property :org_alert_rule, Integer

property :user_org, Integer

property :global_user, Integer

property :global_org, Integer

property :global_dashboard, Integer

property :global_api_key, Integer

property :global_session, Integer

property :global_alert_rule, Integer

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config_set(rp.to_s, new_resource.send(rp))
  end
end
