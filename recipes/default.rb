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

unless Chef::Config[:solo] || node['grafana']['es_role'].nil?
  es_server_results = search(:node, "roles:#{node['grafana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.default['grafana']['es_server'] = es_server_results.first['ipaddress']
  end
end

unless Chef::Config[:solo] || node['grafana']['graphite_role'].nil?
  graphite_server_results = search(:node, "roles:#{node['grafana']['graphite_role']} AND chef_environment:#{node.chef_environment}")
  unless graphite_server_results.empty?
    node.default['grafana']['graphite_server'] = graphite_server_results.first['ipaddress']
  end
end

unless node['grafana']['webserver'].empty?
  include_recipe "grafana::_#{node['grafana']['webserver']}"
end

include_recipe "grafana::_install_#{node['grafana']['install_type']}"

template '/etc/default/grafana-server' do
  source 'grafana-env.erb'
  variables {}
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :delayed
end

template '/etc/grafana/grafana.ini' do
  source 'grafana.ini.erb'
  variables {}
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :delayed
end

service 'grafana-server' do
  supports :start => true, :stop => true, :restart => true, :status => true, :reload => false
  action [:enable, :start]
end
