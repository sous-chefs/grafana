#
# Cookbook:: grafana
# Resource:: config_security
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

property  :instance_name,                         String,         name_property: true
property  :conf_directory,                        String,         default: '/etc/grafana'
property  :config_file,                           String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :admin_user,                            String,         default: 'admin'
property  :admin_password,                        String,         default: 'admin'
property  :secret_key,                            String,         default: 'SW2YcwTIb9zpOOhoPsMm'
property  :login_remember_days,                   Integer,        default: 7
property  :cookie_username,                       String,         default: 'grafana_user'
property  :cookie_remember_name,                  String,         default: 'grafana_remember'
property  :disable_gravatar,                      [true, false],  default: false
property  :data_source_proxy_whitelist,           String,         default: ''
property  :disable_brute_force_login_protection,  [true, false],  default: false
property  :allow_embedding,                       [true, false],  default: false
property  :cookbook,                              String,         default: 'grafana'
property  :source,                                String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['security'] ||= {}
      variables['grafana']['security']['admin_user'] ||= '' unless new_resource.admin_user.nil?
      variables['grafana']['security']['admin_user'] << new_resource.admin_user.to_s unless new_resource.admin_user.nil?
      variables['grafana']['security']['admin_password'] ||= '' unless new_resource.admin_password.nil?
      variables['grafana']['security']['admin_password'] << new_resource.admin_password.to_s unless new_resource.admin_password.nil?
      variables['grafana']['security']['secret_key'] ||= '' unless new_resource.secret_key.nil?
      variables['grafana']['security']['secret_key'] << new_resource.secret_key.to_s unless new_resource.secret_key.nil?
      variables['grafana']['security']['login_remember_days'] ||= '' unless new_resource.login_remember_days.nil?
      variables['grafana']['security']['login_remember_days'] << new_resource.login_remember_days.to_s unless new_resource.login_remember_days.nil?
      variables['grafana']['security']['cookie_username'] ||= '' unless new_resource.cookie_username.nil?
      variables['grafana']['security']['cookie_username'] << new_resource.cookie_username.to_s unless new_resource.cookie_username.nil?
      variables['grafana']['security']['cookie_remember_name'] ||= '' unless new_resource.cookie_remember_name.nil?
      variables['grafana']['security']['cookie_remember_name'] << new_resource.cookie_remember_name.to_s unless new_resource.cookie_remember_name.nil?
      variables['grafana']['security']['disable_gravatar'] ||= '' unless new_resource.disable_gravatar.nil?
      variables['grafana']['security']['disable_gravatar'] << new_resource.disable_gravatar.to_s unless new_resource.disable_gravatar.nil?
      variables['grafana']['security']['data_source_proxy_whitelist'] ||= '' unless new_resource.data_source_proxy_whitelist.nil?
      variables['grafana']['security']['data_source_proxy_whitelist'] << new_resource.data_source_proxy_whitelist.to_s unless new_resource.data_source_proxy_whitelist.nil?
      variables['grafana']['security']['disable_brute_force_login_protection'] ||= '' unless new_resource.disable_brute_force_login_protection.nil?
      variables['grafana']['security']['disable_brute_force_login_protection'] << new_resource.disable_brute_force_login_protection.to_s unless new_resource.disable_brute_force_login_protection.nil?
      variables['grafana']['security']['allow_embedding'] ||= '' unless new_resource.allow_embedding.nil?
      variables['grafana']['security']['allow_embedding'] << new_resource.allow_embedding.to_s unless new_resource.allow_embedding.nil?

      action :nothing
      delayed_action :create
    end
  end
end
