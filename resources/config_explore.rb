#
# Cookbook:: grafana
# Resource:: config_explore
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

property  :instance_name,   String,         name_property: true
property  :enabled,         [true, false],  default: false

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['explore'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['explore']['enabled'] ||= '' unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['explore']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
end
