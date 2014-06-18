#
# Cookbook Name:: grafana
# Recipe:: install_file
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

include_recipe 'ark::default'
ark 'grafana' do
  url node['grafana']['file']['url']
  path node['grafana']['install_path']
  checksum  node['grafana']['file']['checksum']
  owner grafana_user
  strip_leading_dir (node['grafana']['file']['version'] > '1.5.1')
  action :put
end
