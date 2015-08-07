#
# Cookbook Name:: grafana
# Recipe:: default
#
# Copyright 2014, Jonathan Tron
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

unless node['grafana']['webserver'].empty?
  include_recipe "grafana::_#{node['grafana']['webserver']}"
end

include_recipe "grafana::_install_#{node['grafana']['install_type']}"

service 'grafana-server' do
  supports start: true, stop: true, restart: true, status: true, reload: false
  action :enable
end

directory node['grafana']['data_dir'] do
  owner node['grafana']['user']
  group node['grafana']['group']
  mode '0755'
  action :create
end

directory node['grafana']['log_dir'] do
  owner node['grafana']['user']
  group node['grafana']['group']
  mode '0755'
  action :create
end

template '/etc/default/grafana-server' do
  source 'grafana-env.erb'
  variables(
    grafana_user: node['grafana']['user'],
    grafana_group: node['grafana']['group'],
    grafana_home: node['grafana']['home'],
    log_dir: node['grafana']['log_dir'],
    data_dir: node['grafana']['data_dir'],
    conf_dir: node['grafana']['conf_dir']
  )
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :delayed
end

ini = node['grafana']['ini'].dup
ini['paths'] ||= {}
ini['paths']['data'] = node['grafana']['data_dir']
ini['paths']['logs'] = node['grafana']['log_dir']

template "#{node['grafana']['conf_dir']}/grafana.ini" do
  source 'grafana.ini.erb'
  variables ini: ini
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :immediately
end
