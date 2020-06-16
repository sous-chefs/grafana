#
# Cookbook:: grafana
# Resource:: config_dashboards
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

property  :instance_name,     String,   name_property: true
property  :versions_to_keep,  Integer,  default: 20
property  :min_refresh_interval, String, default: '5s'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['dashboards'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['dashboards']['versions_to_keep'] ||= '' unless new_resource.versions_to_keep.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['dashboards']['versions_to_keep'] << new_resource.versions_to_keep.to_s unless new_resource.versions_to_keep.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['dashboards']['min_refresh_interval'] ||= '' unless new_resource.min_refresh_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['dashboards']['min_refresh_interval'] << new_resource.min_refresh_interval.to_s unless new_resource.min_refresh_interval.nil?
end
