#
# Cookbook Name:: grafana
# Recipe:: default
#
# Copyright 2014, Jonathan Tron
# Copyright 2017, Andrei Skopenko
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

if node['grafana']['manage_install']
  include_recipe "grafana::_install_#{node['grafana']['install_type']}"
end

[node['grafana']['data_dir'], node['grafana']['plugins_dir'], node['grafana']['log_dir']].each do |dir|
  directory dir do
    owner node['grafana']['user']
    group node['grafana']['group']
    mode '0755'
    action :create
  end
end

template ::File.join(node['grafana']['env_dir'], 'grafana-server') do
  source 'grafana-env.erb'
  variables(
    grafana_user: node['grafana']['user'],
    grafana_group: node['grafana']['group'],
    grafana_home: node['grafana']['home'],
    log_dir: node['grafana']['log_dir'],
    data_dir: node['grafana']['data_dir'],
    conf_dir: node['grafana']['conf_dir'],
    plugins_dir: node['grafana']['plugins_dir'],
    pid_dir: node['grafana']['pid_dir'],
    restart_on_upgrade: node['grafana']['restart_on_upgrade']
  )
  mode '0644'
  notifies :restart, 'service[grafana-server]'
end

template ::File.join(node['grafana']['conf_dir'], 'grafana.ini') do
  source 'grafana.ini.erb'
  variables ini: node['grafana']['ini']
  group node['grafana']['group']
  mode '0644'
  sensitive true
  notifies :restart, 'service[grafana-server]'
end

unless node['grafana']['ini']['auth.ldap']['enabled']['value'] == false
  include_recipe 'grafana::_ldap_config'
end

service 'grafana-server' do
  supports start: true, stop: true, restart: true, status: true, reload: false
  action [:enable, :start]
end
