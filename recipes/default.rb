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

unless Chef::Config[:solo] || node['grafana']['es_server']
  es_server_results = search(:node, "roles:#{node['grafana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.default['grafana']['es_server'] = es_server_results.first['ipaddress']
  end
end

unless Chef::Config[:solo] || node['grafana']['graphite_server']
  graphite_server_results = search(:node, "roles:#{node['grafana']['graphite_role']} AND chef_environment:#{node.chef_environment}")
  unless graphite_server_results.empty?
    node.default['grafana']['graphite_server'] = graphite_server_results.first['ipaddress']
  end
end

directory node['grafana']['install_dir'] do
  owner grafana_user
  mode "0755"
end

case  node['grafana']['install_type']
  when "git"
    include_recipe 'grafana::install_git'
  when "file"
    include_recipe 'grafana::install_file'
end

template "#{node['grafana']['web_dir']}/config.js" do
  source node['grafana']['config_template']
  cookbook node['grafana']['config_cookbook']
  mode "0750"
  user grafana_user
end

unless node['grafana']['webserver'].empty?
  include_recipe "grafana::#{node['grafana']['webserver']}"
end
