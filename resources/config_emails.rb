#
# Cookbook:: grafana
# Resource:: config_emails
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
property  :welcome_email_on_sign_up,  [true, false],  default: false
property  :templates_pattern,         String,         default: 'emails/*.html'
property  :cookbook,                  String,         default: 'grafana'
property  :source,                    String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['emails'] ||= {}
      variables['grafana']['emails']['welcome_email_on_sign_up'] ||= '' unless new_resource.welcome_email_on_sign_up.nil?
      variables['grafana']['emails']['welcome_email_on_sign_up'] << new_resource.welcome_email_on_sign_up.to_s unless new_resource.welcome_email_on_sign_up.nil?
      variables['grafana']['emails']['templates_pattern'] ||= '' unless new_resource.templates_pattern.nil?
      variables['grafana']['emails']['templates_pattern'] << new_resource.templates_pattern.to_s unless new_resource.templates_pattern.nil?

      action :nothing
      delayed_action :create
    end
  end
end
