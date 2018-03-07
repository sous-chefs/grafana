#
# Cookbook Name:: grafana
# Recipe:: nginx
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

node.default['nginx']['repo_source'] = 'nginx'
node.default['nginx']['default_site_enabled'] = false
node.default['nginx']['server_tokens'] = 'off'
include_recipe 'nginx'

nginx_site 'Grafana' do
  template node['grafana']['nginx']['template']
  cookbook node['grafana']['nginx']['template_cookbook']
  variables(
    grafana_port: node['grafana']['ini']['server']['http_port'] || 3000,
    server_name: node['grafana']['webserver_hostname'],
    server_aliases: node['grafana']['webserver_aliases'],
    listen_address: node['grafana']['webserver_listen'],
    listen_port: node['grafana']['webserver_port']
  )
  action :enable
end
