# Cookbook:: grafana
# Resource:: _config_file
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

unified_mode true

property  :sensitive,           [true, false],            default: true
property  :conf_directory,      String,                   default: '/etc/grafana'
property  :config_file,         String,                   default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :config_file_ldap,    String,                   default: lazy { ::File.join(conf_directory, 'ldap.toml') }
property  :cookbook,            String,                   default: 'grafana'
property  :source,              String,                   default: 'grafana.ini.erb'
property  :source_ldap,         String,                   default: 'ldap.toml.erb'
property  :source_env,          String,                   default: 'grafana-env.erb'
property  :owner,               String,                   default: 'root'
property  :group,               String,                   default: 'grafana'
property  :filemode,            String,                   default: '0640'

action_class do
  include GrafanaCookbook::ConfigHelper
end
