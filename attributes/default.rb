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

# default['grafana']['git']['url'] = 'https://github.com/grafana/grafana'
# default['grafana']['git']['branch'] = 'master'
# default['grafana']['git']['type'] = 'sync' # checkout | sync

# default['grafana']['file']['type'] = 'tar.gz' # tar.gz | zip
default['grafana']['file']['version'] = '2.0.2'
# default['grafana']['file']['url'] = 'http://grafanarel.s3.amazonaws.com/grafana-%{version}.%{type}'
# default['grafana']['file']['checksum'] = 'c328c7a002622f672affbcaabd5e64ae279be1051ee27c62ba22bfed63680508' # sha256 ( shasum -a 256 FILENAME )

default['grafana']['package']['repo'] = 'https://packagecloud.io/grafana/stable/'
default['grafana']['package']['key'] = 'https://packagecloud.io/gpg.key'
default['grafana']['package']['components'] = ['main']

default['grafana']['webserver'] = 'nginx'
default['grafana']['install_path'] = '/srv/apps'
default['grafana']['install_dir'] = "#{node['grafana']['install_path']}/grafana"
default['grafana']['admin_password'] = ''

case node['grafana']['install_type']
when 'file'
  default['grafana']['web_dir'] = node['grafana']['install_dir']
when 'package'
  default['grafana']['web_dir'] = node['grafana']['install_dir']
when 'source'
  default['grafana']['web_dir'] = node['grafana']['install_dir']
end

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
default['grafana']['user'] = ''
default['grafana']['config_template'] = 'config.js.erb'
default['grafana']['config_cookbook'] = 'grafana'
default['grafana']['webserver_hostname'] = node.name
default['grafana']['webserver_aliases'] = [node['ipaddress']]
default['grafana']['webserver_listen'] = node['ipaddress']
default['grafana']['webserver_port'] = 80
default['grafana']['webserver_scheme'] = 'http://'

# config.js
# default['grafana']['default_route'] = '/dashboard/file/default.json'
# default['grafana']['timezone_offset'] = 'null' # Example: "-0500" (for UTC - 5 hours)
# default['grafana']['grafana_index'] = 'grafana-index'
# default['grafana']['unsaved_changes_warning'] = 'true'
# default['grafana']['playlist_timespan'] = '1m'
# default['grafana']['window_title_prefix'] = 'Grafana - '
# default['grafana']['search_max_results'] = 20
# default['grafana']['datasources'] = {
#   'graphite' => {
#     'type' => "'graphite'",
#     'url'  => 'window.location.protocol+"//"+window.location.hostname+":"+window.location.port+"/_graphite"',
#     'default' => true
#   },
#   'elasticsearch' => {
#     'type' => "'elasticsearch'",
#     'url'  => 'window.location.protocol+"//"+window.location.hostname+":"+window.location.port',
#     'index' => lambda { "'#{node['grafana']['grafana_index']}'" },
#     'grafanaDB' => true
#   }
# }
