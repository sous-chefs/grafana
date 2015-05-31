#
# Cookbook Name:: grafana
# Attributes:: default
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

default['grafana']['install_type'] = 'file' # file | package | source
default['grafana']['version'] = '2.0.2'

default['grafana']['file']['url'] = 'http://grafanarel.s3.amazonaws.com/grafana-%{version}.%{type}'
default['grafana']['file']['checksum'] = 'c328c7a002622f672affbcaabd5e64ae279be1051ee27c62ba22bfed63680508' # sha256 ( shasum -a 256 FILENAME )

default['grafana']['package']['repo'] = 'https://packagecloud.io/grafana/stable/'
default['grafana']['package']['key'] = 'https://packagecloud.io/gpg.key'
default['grafana']['package']['components'] = ['main']

default['grafana']['webserver'] = 'nginx'
default['grafana']['user'] = 'grafana'
default['grafana']['group'] = 'grafana'
default['grafana']['home'] = '/usr/share/grafana'
default['grafana']['data_dir'] = '/var/lib/grafana'
default['grafana']['log_dir'] = '/var/log/grafana'
case node['platform_family']
when 'debian'
  default['grafana']['env_dir'] = '/etc/default'
when 'rhel', 'fedora'
  default['grafana']['env_dir'] = '/etc/sysconfig'
end
default['grafana']['conf_dir'] = '/etc/grafana'
default['grafana']['http_addr'] = nil
default['grafana']['http_protocol'] = 'http'
default['grafana']['http_port'] = 3000
default['grafana']['http_domain'] = 'localhost'
default['grafana']['database']['type'] = 'sqlite3'
default['grafana']['database']['host'] = '127.0.0.1:3306'
default['grafana']['database']['name'] = 'grafana'
default['grafana']['database']['user'] = 'root'
default['grafana']['database']['password'] = ''
default['grafana']['admin_user'] = 'admin'
default['grafana']['admin_password'] = 'admin'
default['grafana']['session_provider'] = 'memory'
default['grafana']['session_provider_config'] = 'sessions'
default['grafana']['session_life_time'] = 86400
default['grafana']['reporting_enabled'] = true
default['grafana']['allow_sign_up'] = true
default['grafana']['allow_org_create'] = true
default['grafana']['auto_assign_org'] = true
default['grafana']['auto_assign_org_role'] = 'Viewer'
default['grafana']['anon_auth_enabled'] = false
default['grafana']['anon_auth_org_name'] = 'Main Org.'
default['grafana']['anon_auth_org_role'] = 'Viewer'
default['grafana']['log_level'] = 'Info'
default['grafana']['log_daily_rotate'] = true
default['grafana']['log_max_days'] = 7

# graphite
default['grafana']['graphite_server'] = '127.0.0.1'
default['grafana']['graphite_port'] = '80'
default['grafana']['graphite_role'] = 'graphite_server'
default['grafana']['graphite_scheme'] = 'http://'
default['grafana']['graphite_user'] = ''
default['grafana']['graphite_password'] = ''

# webserver
default['grafana']['webserver_hostname'] = node.name
default['grafana']['webserver_aliases'] = [node['ipaddress']]
default['grafana']['webserver_listen'] = node['ipaddress']
default['grafana']['webserver_port'] = 80
default['grafana']['webserver_scheme'] = 'http://'
