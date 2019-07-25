#
# Cookbook:: grafana
# Resource:: config_alerting
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
property  :enabled,                 [true, false],  default: true
property  :execute_alerts,          [true, false],  default: true
property  :error_or_timeout,        String,         default: 'alerting'
property  :nodata_or_nullvalues,    String,         default: 'no_data'
property  :concurrent_render_limit, Integer,        default: 5
property  :cookbook,                String,         default: 'grafana'
property  :source,                  String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['alerting'] ||= {}
      variables['grafana']['alerting']['enabled'] ||= '' unless new_resource.enabled.nil?
      variables['grafana']['alerting']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
      variables['grafana']['alerting']['execute_alerts'] ||= '' unless new_resource.execute_alerts.nil?
      variables['grafana']['alerting']['execute_alerts'] << new_resource.execute_alerts.to_s unless new_resource.execute_alerts.nil?
      variables['grafana']['alerting']['error_or_timeout'] ||= '' unless new_resource.error_or_timeout.nil?
      variables['grafana']['alerting']['error_or_timeout'] << new_resource.error_or_timeout.to_s unless new_resource.error_or_timeout.nil?
      variables['grafana']['alerting']['nodata_or_nullvalues'] ||= '' unless new_resource.nodata_or_nullvalues.nil?
      variables['grafana']['alerting']['nodata_or_nullvalues'] << new_resource.nodata_or_nullvalues.to_s unless new_resource.nodata_or_nullvalues.nil?
      variables['grafana']['alerting']['concurrent_render_limit'] ||= '' unless new_resource.concurrent_render_limit.nil?
      variables['grafana']['alerting']['concurrent_render_limit'] << new_resource.concurrent_render_limit.to_s unless new_resource.concurrent_render_limit.nil?

      action :nothing
      delayed_action :create
    end
  end
end
