#
# Cookbook:: grafana
# Resource:: config_snapshots
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

property  :instance_name,           String,         name_property: true
property  :external_enabled,        [true, false],  default: true
property  :external_snapshot_url,   String,         default: 'https://snapshots-origin.raintank.io'
property  :external_snapshot_name,  String,         default: 'Publish to snapshot.raintank.io'
property  :snapshot_remove_expired, [true, false],  default: true

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['external_enabled'] ||= '' unless new_resource.external_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['external_enabled'] << new_resource.external_enabled.to_s unless new_resource.external_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['external_snapshot_url'] ||= '' unless new_resource.external_snapshot_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['external_snapshot_url'] << new_resource.external_snapshot_url.to_s unless new_resource.external_snapshot_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['external_snapshot_name'] ||= '' unless new_resource.external_snapshot_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['external_snapshot_name'] << new_resource.external_snapshot_name.to_s unless new_resource.external_snapshot_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['snapshot_remove_expired'] ||= '' unless new_resource.snapshot_remove_expired.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['snapshots']['snapshot_remove_expired'] << new_resource.snapshot_remove_expired.to_s unless new_resource.snapshot_remove_expired.nil?
end
