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
default['grafana']['database']['type'] = 'sqlite3'
default['grafana']['database']['host'] = '127.0.0.1:3306'
default['grafana']['database']['name'] = 'grafana'
default['grafana']['database']['user'] = 'root'
default['grafana']['database']['password'] = ''
# This value can be overridden with an encrypted data bag
default['grafana']['admin_password'] = 'admin'

# elastic search
default['grafana']['es_server'] = '127.0.0.1'
default['grafana']['es_port'] = '9200'
default['grafana']['es_role'] = 'elasticsearch_server'
default['grafana']['es_scheme'] = 'http://'
default['grafana']['es_user'] = ''
default['grafana']['es_password'] = ''

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
