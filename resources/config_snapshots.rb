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
property  :conf_directory,          String,         default: '/etc/grafana'
property  :config_file,             String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :external_enabled,        [true, false],  default: true
property  :external_snapshot_url,   String,         default: 'https://snapshots-origin.raintank.io'
property  :external_snapshot_name,  String,         default: 'Publish to snapshot.raintank.io'
property  :snapshot_remove_expired, [true, false],  default: true
# This matches the name given by Grafana's config file
property  :cookbook,                String,         default: 'grafana'
property  :source,                  String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['snapshots'] ||= {}
      variables['grafana']['snapshots']['external_enabled'] ||= '' unless new_resource.external_enabled.nil?
      variables['grafana']['snapshots']['external_enabled'] << new_resource.external_enabled.to_s unless new_resource.external_enabled.nil?
      variables['grafana']['snapshots']['external_snapshot_url'] ||= '' unless new_resource.external_snapshot_url.nil?
      variables['grafana']['snapshots']['external_snapshot_url'] << new_resource.external_snapshot_url.to_s unless new_resource.external_snapshot_url.nil?
      variables['grafana']['snapshots']['external_snapshot_name'] ||= '' unless new_resource.external_snapshot_name.nil?
      variables['grafana']['snapshots']['external_snapshot_name'] << new_resource.external_snapshot_name.to_s unless new_resource.external_snapshot_name.nil?
      variables['grafana']['snapshots']['snapshot_remove_expired'] ||= '' unless new_resource.snapshot_remove_expired.nil?
      variables['grafana']['snapshots']['snapshot_remove_expired'] << new_resource.snapshot_remove_expired.to_s unless new_resource.snapshot_remove_expired.nil?

      action :nothing
      delayed_action :create
    end
  end
end
