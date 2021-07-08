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
# Configures the installed grafana instance's ldap servers
# See https://raw.githubusercontent.com/grafana/grafana/master/conf/ldap.toml
# Expects config_ldap to have been called before this

unified_mode true

use 'partial/_config_file'

property  :instance_name,                       String,                   name_property: true
property  :host,                                String,                   required: true
property  :port,                                Integer,                  default: 389
property  :use_ssl,                             [true, false],            default: false
property  :start_tls,                           [true, false],            default: false
property  :ssl_skip_verify,                     [true, false],            default: false
property  :root_ca_cert,                        String
property  :client_cert,                         String
property  :client_key,                          String
property  :bind_dn,                             String,                   default: 'cn=admin,dc=grafana,dc=org'
property  :bind_password,                       String,                   default: 'grafana', sensitive: true
property  :search_filter,                       String,                   default: '(cn=%s)'
property  :search_base_dns,                     Array,                    default: []
property  :group_search_base_dns,               Array,                    default: []
property  :group_search_filter,                 String
property  :group_search_filter_user_attribute,  String

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp), new_resource.instance_name, 'ldap', 'servers', new_resource.host)
  end
end
