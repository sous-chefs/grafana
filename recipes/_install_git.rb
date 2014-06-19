#
# Cookbook Name:: grafana
# Recipe:: install_git
#
# Copyright 2014, Grégoire Seux
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

include_recipe 'git'

git "#{node['grafana']['install_dir']}/#{node['grafana']['git']['branch']}" do
  repository node['grafana']['git']['url']
  reference node['grafana']['git']['branch']
  action node['grafana']['git']['type'].to_s
  user grafana_user
end

link "#{node['grafana']['install_dir']}/current" do
  to "#{node['grafana']['install_dir']}/#{node['grafana']['git']['branch']}"
end
