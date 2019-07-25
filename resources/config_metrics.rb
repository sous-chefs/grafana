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

property  :instance_name,       String,         name_property: true
property  :conf_directory,      String,         default: '/etc/grafana'
property  :config_file,         String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :enabled,             [true, false],  default: true
property  :interval_seconds,    Integer,        default: 10
property  :basic_auth_username, String,         default: ''
property  :basic_auth_password, String,         default: ''
property  :graphite_address,    String,         default: ''
property  :graphite_prefix,     String,         default: 'prod.grafana.%(instance_name)s.'
property  :cookbook,            String,         default: 'grafana'
property  :source,              String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['metrics'] ||= {}
      variables['grafana']['metrics']['enabled'] ||= '' unless new_resource.enabled.nil?
      variables['grafana']['metrics']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
      variables['grafana']['metrics']['interval_seconds'] ||= '' unless new_resource.interval_seconds.nil?
      variables['grafana']['metrics']['interval_seconds'] << new_resource.interval_seconds.to_s unless new_resource.interval_seconds.nil?
      variables['grafana']['metrics']['basic_auth_username'] ||= '' unless new_resource.basic_auth_username.nil?
      variables['grafana']['metrics']['basic_auth_username'] << new_resource.basic_auth_username.to_s unless new_resource.basic_auth_username.nil?
      variables['grafana']['metrics']['basic_auth_password'] ||= '' unless new_resource.basic_auth_password.nil?
      variables['grafana']['metrics']['basic_auth_password'] << new_resource.basic_auth_password.to_s unless new_resource.basic_auth_password.nil?

      variables['grafana']['metrics_graphite'] ||= {}
      variables['grafana']['metrics_graphite']['address'] ||= '' unless new_resource.graphite_address.nil?
      variables['grafana']['metrics_graphite']['address'] << new_resource.graphite_address.to_s unless new_resource.graphite_address.nil?
      variables['grafana']['metrics_graphite']['prefix'] ||= '' unless new_resource.graphite_prefix.nil?
      variables['grafana']['metrics_graphite']['prefix'] << new_resource.graphite_prefix.to_s unless new_resource.graphite_prefix.nil?

      action :nothing
      delayed_action :create
    end
  end
end
