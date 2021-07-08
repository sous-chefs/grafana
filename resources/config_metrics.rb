#
# Cookbook:: grafana
# Resource:: config_metrics
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

property  :instance_name,       String,         name_property: true
property  :enabled,             [true, false],  default: true
property  :interval_seconds,    Integer,        default: 10
property  :basic_auth_username, String,         default: ''
property  :basic_auth_password, String,         default: ''
property  :graphite_address,    String,         default: ''
property  :graphite_prefix,     String,         default: 'prod.grafana.%(instance_name)s.'

action_class do
  include GrafanaCookbook::ConfigHelper

  RESOURCE_PROPERTIES = {
    'metrics' => %i(enabled interval_seconds basic_auth_username basic_auth_password),
    'metrics_graphite' => %i(graphite_address graphite_prefix),
  }.freeze
end

action :install do
  RESOURCE_PROPERTIES.each do |type, properties|
    properties.each do |rp|
      next if nil_or_empty?(new_resource.send(rp))

      property_prefix = "#{type.delete_prefix('metrics_')}_"
      run_state_config_set(rp.to_s.delete_prefix(property_prefix), new_resource.send(rp), new_resource.instance_name, 'config', type)
    end
  end
end
