#
# Cookbook:: grafana
# Resource:: config_rendering
#
# Copyright:: 2020, Sous Chefs
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

property  :instance_name, String, name_property: true
property  :server_url,    String, default: 'http://localhost:8081/render'
property  :callback_url,  String, default: 'http://localhost:3000/'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['rendering'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['rendering']['server_url'] ||= '' unless new_resource.server_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['rendering']['server_url'] << new_resource.server_url.to_s unless new_resource.server_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['rendering']['callback_url'] ||= '' unless new_resource.callback_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['rendering']['callback_url'] << new_resource.callback_url.to_s unless new_resource.callback_url.nil?
end
