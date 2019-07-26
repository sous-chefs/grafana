#
# Cookbook:: grafana
# Resource:: config_alerting
#
# Copyright:: 2019, Sous Chefs
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
# Configures the installed grafana instance's ldap settings
# See https://raw.githubusercontent.com/grafana/grafana/master/conf/ldap.toml

property  :instance_name,                 String, name_property: true
property  :conf_directory,                String, default: '/etc/grafana'
property  :config_file,                   String, default: lazy { ::File.join(conf_directory, 'ldap.toml') }
property  :log_filters,                   String
property  :servers_attributes_name,       String, default: 'givenName'
property  :servers_attributes_surname,    String, default: 'sn'
property  :servers_attributes_username,   String, default: 'cn'
property  :servers_attributes_member_of,  String, default: 'memberOf'
property  :servers_attributes_email,      String, default: 'email'
property  :cookbook,                      String, default: 'grafana'
property  :source,                        String, default: 'ldap.toml.erb'

action :install do
  service 'grafana-server' do
    action :enable
    subscribes :restart, "template[#{new_resource.config_file}]", :immediately
  end

  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana'] ||= {}
      variables['grafana']['ldap'] ||= {}
      variables['grafana']['ldap']['log_filters'] ||= '' unless new_resource.log_filters.nil?
      variables['grafana']['ldap']['log_filters'] << new_resource.log_filters.to_s unless new_resource.log_filters.nil?
      variables['grafana']['ldap']['servers_attributes_name'] ||= '' unless new_resource.servers_attributes_name.nil?
      variables['grafana']['ldap']['servers_attributes_name'] << new_resource.servers_attributes_name.to_s unless new_resource.servers_attributes_name.nil?
      variables['grafana']['ldap']['servers_attributes_surname'] ||= '' unless new_resource.servers_attributes_surname.nil?
      variables['grafana']['ldap']['servers_attributes_surname'] << new_resource.servers_attributes_surname.to_s unless new_resource.servers_attributes_surname.nil?
      variables['grafana']['ldap']['servers_attributes_username'] ||= '' unless new_resource.servers_attributes_username.nil?
      variables['grafana']['ldap']['servers_attributes_username'] << new_resource.servers_attributes_username.to_s unless new_resource.servers_attributes_username.nil?
      variables['grafana']['ldap']['servers_attributes_member_of'] ||= '' unless new_resource.servers_attributes_member_of.nil?
      variables['grafana']['ldap']['servers_attributes_member_of'] << new_resource.servers_attributes_member_of.to_s unless new_resource.servers_attributes_member_of.nil?
      variables['grafana']['ldap']['servers_attributes_email'] ||= '' unless new_resource.servers_attributes_email.nil?
      variables['grafana']['ldap']['servers_attributes_email'] << new_resource.servers_attributes_email.to_s unless new_resource.servers_attributes_email.nil?
      action :nothing
      delayed_action :create
      service 'grafana-server'
      notifies :restart, 'service[grafana-server]'
    end
  end
end
