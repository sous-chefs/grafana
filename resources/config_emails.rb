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
property  :welcome_email_on_sign_up,  [true, false],  default: false
property  :templates_pattern,         String,         default: 'emails/*.html'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['emails'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['emails']['welcome_email_on_sign_up'] ||= '' unless new_resource.welcome_email_on_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['emails']['welcome_email_on_sign_up'] << new_resource.welcome_email_on_sign_up.to_s unless new_resource.welcome_email_on_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['emails']['templates_pattern'] ||= '' unless new_resource.templates_pattern.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['emails']['templates_pattern'] << new_resource.templates_pattern.to_s unless new_resource.templates_pattern.nil?
end
