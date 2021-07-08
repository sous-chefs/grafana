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

unified_mode true

use 'partial/_config_file'

property  :instance_name,                 String, name_property: true
property  :log_filters,                   String
property  :servers_attributes_name,       String, default: 'givenName'
property  :servers_attributes_surname,    String, default: 'sn'
property  :servers_attributes_username,   String, default: 'cn'
property  :servers_attributes_member_of,  String, default: 'memberOf'
property  :servers_attributes_email,      String, default: 'email'

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp), new_resource.instance_name, 'ldap')
  end

  # Log filters go in the main config file
  run_state_config_set(rp.to_s, new_resource.log_filters, new_resource.instance_name, 'config', 'log') unless nil_or_empty?(new_resource.log_filters)
end
