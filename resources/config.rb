#
# Cookbook:: grafana
# Resource:: config
#
# Copyright:: 2014, Jonathan Tron
# Copyright:: 2017, Andrei Skopenko
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

property :app_mode, String,
          default: 'production',
          equal_to: %w(production development)

property :instance_name, String,
          name_property: true

action_class do
  RESOURCE_CONFIG_PROPERTIES_SKIP = %i(env_directory restart_on_upgrade).freeze

  def resource_config_properties_skip
    RESOURCE_CONFIG_PROPERTIES_SKIP
  end
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp), 'global')
  end

  new_resource.extra_options.each { |key, value| accumulator_config(:push, :push, key, value, 'global') } if property_is_set?(:extra_options)
end
