#
# Cookbook:: grafana
# Resource:: config_users
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

property  :instance_name,             String,         name_property: true
property  :conf_directory,            String,         default: '/etc/grafana'
property  :config_file,               String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :allow_sign_up,             [true, false],  default: false
property  :allow_org_create,          [true, false],  default: false
property  :auto_assign_org,           [true, false],  default: true
property  :auto_assign_org_id,        Integer,        default: 1
property  :auto_assign_org_role,      String,         default: 'Viewer'
property  :verify_email_enabled,      [true, false],  default: false
property  :login_hint,                String,         default: 'email or username'
property  :default_theme,             String,         default: 'dark', equal_to: %w(dark light)
property  :external_manage_link_url,  String,         default: ''
property  :external_manage_link_name, String,         default: ''
property  :external_manage_info,      String,         default: ''
property  :viewers_can_edit,          [true, false],  default: false
property  :cookbook,                  String,         default: 'grafana'
property  :source,                    String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['users'] ||= {}
      variables['grafana']['users']['allow_sign_up'] ||= '' unless new_resource.allow_sign_up.nil?
      variables['grafana']['users']['allow_sign_up'] << new_resource.allow_sign_up.to_s unless new_resource.allow_sign_up.nil?
      variables['grafana']['users']['allow_org_create'] ||= '' unless new_resource.allow_org_create.nil?
      variables['grafana']['users']['allow_org_create'] << new_resource.allow_org_create.to_s unless new_resource.allow_org_create.nil?
      variables['grafana']['users']['auto_assign_org'] ||= '' unless new_resource.auto_assign_org.nil?
      variables['grafana']['users']['auto_assign_org'] << new_resource.auto_assign_org.to_s unless new_resource.auto_assign_org.nil?
      variables['grafana']['users']['auto_assign_org_id'] ||= '' unless new_resource.auto_assign_org_id.nil?
      variables['grafana']['users']['auto_assign_org_id'] << new_resource.auto_assign_org_id.to_s unless new_resource.auto_assign_org_id.nil?
      variables['grafana']['users']['auto_assign_org_role'] ||= '' unless new_resource.auto_assign_org_role.nil?
      variables['grafana']['users']['auto_assign_org_role'] << new_resource.auto_assign_org_role.to_s unless new_resource.auto_assign_org_role.nil?
      variables['grafana']['users']['verify_email_enabled'] ||= '' unless new_resource.verify_email_enabled.nil?
      variables['grafana']['users']['verify_email_enabled'] << new_resource.verify_email_enabled.to_s unless new_resource.verify_email_enabled.nil?
      variables['grafana']['users']['login_hint'] ||= '' unless new_resource.login_hint.nil?
      variables['grafana']['users']['login_hint'] << new_resource.login_hint.to_s unless new_resource.login_hint.nil?
      variables['grafana']['users']['default_theme'] ||= '' unless new_resource.default_theme.nil?
      variables['grafana']['users']['default_theme'] << new_resource.default_theme.to_s unless new_resource.default_theme.nil?
      variables['grafana']['users']['external_manage_link_url'] ||= '' unless new_resource.external_manage_link_url.nil?
      variables['grafana']['users']['external_manage_link_url'] << new_resource.external_manage_link_url.to_s unless new_resource.external_manage_link_url.nil?
      variables['grafana']['users']['external_manage_link_name'] ||= '' unless new_resource.external_manage_link_name.nil?
      variables['grafana']['users']['external_manage_link_name'] << new_resource.external_manage_link_name.to_s unless new_resource.external_manage_link_name.nil?
      variables['grafana']['users']['external_manage_info'] ||= '' unless new_resource.external_manage_info.nil?
      variables['grafana']['users']['external_manage_info'] << new_resource.external_manage_info.to_s unless new_resource.external_manage_info.nil?
      variables['grafana']['users']['viewers_can_edit'] ||= '' unless new_resource.viewers_can_edit.nil?
      variables['grafana']['users']['viewers_can_edit'] << new_resource.viewers_can_edit.to_s unless new_resource.viewers_can_edit.nil?

      action :nothing
      delayed_action :create
    end
  end
end
