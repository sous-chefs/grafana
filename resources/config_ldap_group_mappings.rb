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
# Configures the installed grafana instance's ldap group mappings
# See https://raw.githubusercontent.com/grafana/grafana/master/conf/ldap.toml
# Expects config_ldap to have been called before this

property  :group_dn,                      String,                   name_property: true
property  :conf_directory,                String,                   default: '/etc/grafana'
property  :config_file,                   String,                   default: lazy { ::File.join(conf_directory, 'ldap.toml') }
property  :org_role,                      String,                   default: 'Viewer'
property  :grafana_admin,                 [TrueClass, FalseClass],  default: false
property  :org_id,                        Integer,                  default: 1
property  :cookbook,                      String,                   default: 'grafana'
property  :source,                        String,                   default: 'ldap.toml.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['ldap']['group_mappings'] ||= {}
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn] ||= {}
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn]['org_role'] ||= '' unless new_resource.org_role.nil?
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn]['org_role'] = new_resource.org_role.to_s unless new_resource.org_role.nil?
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn]['grafana_admin'] ||= '' unless new_resource.grafana_admin.nil?
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn]['grafana_admin'] = new_resource.grafana_admin.to_s unless new_resource.grafana_admin.nil?
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn]['org_id'] ||= '' unless new_resource.org_id.nil?
      variables['grafana']['ldap']['group_mappings'][new_resource.group_dn]['org_id'] = new_resource.org_id.to_s unless new_resource.org_id.nil?

      action :nothing
      delayed_action :create
    end
  end
end
