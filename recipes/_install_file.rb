#
# Cookbook Name:: grafana
# Recipe:: _install_file
#
# Copyright 2014, Grégoire Seux
# Copyright 2014, Jonathan Tron
# Copyright 2015, Michael Lanyon
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

case node['platform_family']
when 'debian'
  pkgs = %w(adduser libfontconfig)
  pkgs.each do |pkg|
    package pkg
  end

  grafana_installed = "dpkg -l | grep '^ii' | grep grafana | grep #{node['grafana']['version']}"

  remote_file "#{Chef::Config[:file_cache_path]}/grafana-#{node['grafana']['version']}.deb" do
    source "#{node['grafana']['file']['url']}_#{node['grafana']['version']}_amd64.deb"
    checksum node['grafana']['file']['checksum']['deb']
    action :create
    not_if grafana_installed
  end

  dpkg_package "grafana-#{node['grafana']['version']}" do
    source "#{Chef::Config[:file_cache_path]}/grafana-#{node['grafana']['version']}.deb"
    action :install
    options '--force-confdef,confnew'
    not_if grafana_installed
  end
when 'rhel'
  pkgs = %w(initscripts fontconfig)
  pkgs.each do |pkg|
    package pkg
  end

  grafana_installed = "yum list installed | grep grafana | grep #{node['grafana']['version']}"

  remote_file "#{Chef::Config[:file_cache_path]}/grafana-#{node['grafana']['version']}.rpm" do
    source "#{node['grafana']['file']['url']}-#{node['grafana']['version']}-1.x86_64.rpm"
    checksum node['grafana']['file']['checksum']['rpm']
    action :create
    not_if grafana_installed
  end

  rpm_package "grafana-#{node['grafana']['version']}" do
    source "#{Chef::Config[:file_cache_path]}/grafana-#{node['grafana']['version']}.rpm"
    action :install
    not_if grafana_installed
  end
end
