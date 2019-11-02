#
# Cookbook:: grafana
# Resource:: config_enterprise
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
property  :enable_alpha,    [true, false],  default: false

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['panels'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['panels']['enable_alpha'] ||= '' unless new_resource.enable_alpha.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['panels']['enable_alpha'] << new_resource.enable_alpha.to_s unless new_resource.enable_alpha.nil?
end
