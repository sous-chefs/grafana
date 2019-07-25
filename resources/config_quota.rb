#
# Cookbook:: grafana
# Resource:: config_quota
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

property  :instance_name,     String,         name_property: true
property  :conf_directory,    String,         default: '/etc/grafana'
property  :config_file,       String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :enabled,           [true, false],  default: false
property  :org_user,          Integer,        default: 10
property  :org_dashboard,     Integer,        default: 100
property  :org_data_source,   Integer,        default: 10
property  :org_api_key,       Integer,        default: 10
property  :user_org,          Integer,        default: 10
property  :global_user,       Integer,        default: -1
property  :global_org,        Integer,        default: -1
property  :global_dashboard,  Integer,        default: -1
property  :global_api_key,    Integer,        default: -1
property  :global_session,    Integer,        default: -1
property  :cookbook,          String,         default: 'grafana'
property  :source,            String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['quota'] ||= {}
      variables['grafana']['quota']['enabled'] ||= '' unless new_resource.enabled.nil?
      variables['grafana']['quota']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
      variables['grafana']['quota']['org_user'] ||= '' unless new_resource.org_user.nil?
      variables['grafana']['quota']['org_user'] << new_resource.org_user.to_s unless new_resource.org_user.nil?
      variables['grafana']['quota']['org_dashboard'] ||= '' unless new_resource.org_dashboard.nil?
      variables['grafana']['quota']['org_dashboard'] << new_resource.org_dashboard.to_s unless new_resource.org_dashboard.nil?
      variables['grafana']['quota']['org_data_source'] ||= '' unless new_resource.org_data_source.nil?
      variables['grafana']['quota']['org_data_source'] << new_resource.org_data_source.to_s unless new_resource.org_data_source.nil?
      variables['grafana']['quota']['org_api_key'] ||= '' unless new_resource.org_api_key.nil?
      variables['grafana']['quota']['org_api_key'] << new_resource.org_api_key.to_s unless new_resource.org_api_key.nil?
      variables['grafana']['quota']['user_org'] ||= '' unless new_resource.user_org.nil?
      variables['grafana']['quota']['user_org'] << new_resource.user_org.to_s unless new_resource.user_org.nil?
      variables['grafana']['quota']['global_user'] ||= '' unless new_resource.global_user.nil?
      variables['grafana']['quota']['global_user'] << new_resource.global_user.to_s unless new_resource.global_user.nil?
      variables['grafana']['quota']['global_org'] ||= '' unless new_resource.global_org.nil?
      variables['grafana']['quota']['global_org'] << new_resource.global_org.to_s unless new_resource.global_org.nil?
      variables['grafana']['quota']['global_dashboard'] ||= '' unless new_resource.global_dashboard.nil?
      variables['grafana']['quota']['global_dashboard'] << new_resource.global_dashboard.to_s unless new_resource.global_dashboard.nil?
      variables['grafana']['quota']['global_api_key'] ||= '' unless new_resource.global_api_key.nil?
      variables['grafana']['quota']['global_api_key'] << new_resource.global_api_key.to_s unless new_resource.global_api_key.nil?
      variables['grafana']['quota']['global_session'] ||= '' unless new_resource.global_session.nil?
      variables['grafana']['quota']['global_session'] << new_resource.global_session.to_s unless new_resource.global_session.nil?

      action :nothing
      delayed_action :create
    end
  end
end
