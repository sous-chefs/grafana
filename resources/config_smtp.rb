#
# Cookbook:: grafana
# Resource:: config_smtp
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

property  :instance_name,   String,         name_property: true
property  :conf_directory,  String,         default: '/etc/grafana'
property  :config_file,     String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :enabled,         [true, false],  default: false
property  :host,            String,         default: 'localhost:25'
property  :user,            String,         default: ''
property  :password,        String,         default: ''
property  :cert_file,       String,         default: ''
property  :key_file,        String,         default: ''
property  :skip_verify,     [true, false],  default: false
property  :from_address,    String,         default: "admin@grafana-#{node['hostname']}.#{node['domain'].nil? ? 'local' : node['domain']}"
property  :from_name,       String,         default: 'Grafana'
property  :ehlo_identity,   String,         default: ''
property  :cookbook,        String,         default: 'grafana'
property  :source,          String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['smtp'] ||= {}
      variables['grafana']['smtp']['enabled'] ||= '' unless new_resource.enabled.nil?
      variables['grafana']['smtp']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
      variables['grafana']['smtp']['host'] ||= '' unless new_resource.host.nil?
      variables['grafana']['smtp']['host'] << new_resource.host.to_s unless new_resource.host.nil?
      variables['grafana']['smtp']['user'] ||= '' unless new_resource.user.nil?
      variables['grafana']['smtp']['user'] << new_resource.user.to_s unless new_resource.user.nil?
      variables['grafana']['smtp']['password'] ||= '' unless new_resource.password.nil?
      variables['grafana']['smtp']['password'] << new_resource.password.to_s unless new_resource.password.nil?
      variables['grafana']['smtp']['cert_file'] ||= '' unless new_resource.cert_file.nil?
      variables['grafana']['smtp']['cert_file'] << new_resource.cert_file.to_s unless new_resource.cert_file.nil?
      variables['grafana']['smtp']['key_file'] ||= '' unless new_resource.key_file.nil?
      variables['grafana']['smtp']['key_file'] << new_resource.key_file.to_s unless new_resource.key_file.nil?
      variables['grafana']['smtp']['skip_verify'] ||= '' unless new_resource.skip_verify.nil?
      variables['grafana']['smtp']['skip_verify'] << new_resource.skip_verify.to_s unless new_resource.skip_verify.nil?
      variables['grafana']['smtp']['from_address'] ||= '' unless new_resource.from_address.nil?
      variables['grafana']['smtp']['from_address'] << new_resource.from_address.to_s unless new_resource.from_address.nil?
      variables['grafana']['smtp']['from_name'] ||= '' unless new_resource.from_name.nil?
      variables['grafana']['smtp']['from_name'] << new_resource.from_name.to_s unless new_resource.from_name.nil?
      variables['grafana']['smtp']['ehlo_identity'] ||= '' unless new_resource.ehlo_identity.nil?
      variables['grafana']['smtp']['ehlo_identity'] << new_resource.ehlo_identity.to_s unless new_resource.ehlo_identity.nil?

      action :nothing
      delayed_action :create
    end
  end
end
