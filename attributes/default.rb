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

default['grafana']['manage_install'] = true
default['grafana']['install_type'] = 'file' # file | package
default['grafana']['version'] = '4.6.3'

default['grafana']['file']['url'] = 'https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana'
default['grafana']['file']['checksum']['deb'] = 'd022fceb939e7570d74b437932bee876e306b0e21ecdd830752c61b4e89dab31'
default['grafana']['file']['checksum']['rpm'] = 'bfb639baffb34d43f826c6edc2912a8b79957ab08e777ec77fa7e931f741944c'

case node['platform_family']
when 'debian'
  default['grafana']['package']['repo'] = 'https://packagecloud.io/grafana/stable/debian/'
  default['grafana']['package']['distribution'] = 'wheezy'
  default['grafana']['package']['components'] = ['main']
  default['grafana']['package']['key'] = 'https://packagecloud.io/gpg.key'
  default['grafana']['package']['version'] = node['grafana']['version']
  default['grafana']['package']['apt_rebuild'] = true
  default['grafana']['package']['trusted'] = false
when 'rhel', 'fedora'
  default['grafana']['package']['repo'] = 'https://packagecloud.io/grafana/stable/el/$releasever/$basearch'
  default['grafana']['package']['key'] = 'https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana'
  default['grafana']['package']['version'] = "#{node['grafana']['version']}-1"
  default['grafana']['package']['checkkey'] = true
end

default['grafana']['user'] = 'grafana'
default['grafana']['group'] = 'grafana'
default['grafana']['home'] = '/usr/share/grafana'
default['grafana']['data_dir'] = '/var/lib/grafana'
default['grafana']['log_dir'] = '/var/log/grafana'
default['grafana']['plugins_dir'] = '/var/lib/grafana/plugins'
default['grafana']['pid_dir'] = '/var/run/grafana'

case node['platform_family']
when 'debian'
  default['grafana']['env_dir'] = '/etc/default'
when 'rhel', 'fedora'
  default['grafana']['env_dir'] = '/etc/sysconfig'
end
default['grafana']['conf_dir'] = '/etc/grafana'
default['grafana']['restart_on_upgrade'] = false

## ini file configuration
# format is the following [section][key] = value
# with value being either
# - the real value
# - a hash { comment: 'a comment', disable: true|false, value: 'the real value' } with disable: true to add the ; prefix
#
# Grafana has pretty good default value, the following default attributes are only here to show how to configure grafana via attributes

# no section parameters
default['grafana']['ini'][nil]['app_mode'] = 'production'

default['grafana']['ini']['database']['type'] = {
  comment: "Either mysl, postgres, sqlite3, it's your choice",
  disable: false,
  value: 'sqlite3',
}
default['grafana']['ini']['database']['host'] = '127.0.0.1:3306'
default['grafana']['ini']['database']['name'] = 'grafana'
default['grafana']['ini']['database']['user'] = 'root'
default['grafana']['ini']['database']['password'] = ''
default['grafana']['ini']['database']['ssl_mode'] = {
  comment: 'For "postgres" only, either "disable", "require" or "verify-full"',
  disable: true,
  value: 'disable',
}
default['grafana']['ini']['database']['path'] = {
  comment: 'For sqlite3 only, path relative to data_path setting',
  disable: false,
  value: 'grafana.db',
}
default['grafana']['ini']['paths'] = {
  data: node['grafana']['data_dir'],
  logs: node['grafana']['log_dir'],
  plugins: node['grafana']['plugins_dir'],
}

default['grafana']['ini']['auth.ldap']['enabled'] = {
  comment: '',
  disable: true,
  value: false,
}
default['grafana']['ini']['auth.ldap']['config_file'] = {
  disable: true,
  value: '/etc/grafana/ldap.toml',
}

# server
default['grafana']['ini']['server']['protocol'] = 'http'
default['grafana']['ini']['server']['http_port'] = 3000
default['grafana']['ini']['server']['domain'] = 'localhost'

# webserver
default['grafana']['webserver'] = 'nginx'
default['grafana']['webserver_hostname'] = node.name
default['grafana']['webserver_aliases'] = [node['ipaddress']]
default['grafana']['webserver_listen'] = node['ipaddress']
default['grafana']['webserver_port'] = 80

# Plugins
default['grafana']['cli_bin'] = '/usr/sbin/grafana-cli'
default['grafana']['plugins'] = []
