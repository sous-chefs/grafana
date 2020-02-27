#
# Cookbook:: grafana
# Resource:: install
#
# Copyright:: 2014, Jonathan Tron
# Copyright:: 2017, Andrei Skopenko
# Copyright:: 2018, Sous Chefs
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

property :version,          String, required: false
property :repo,             String, default:  'https://packages.grafana.com/oss'
property :key,              String, default:  'https://packages.grafana.com/gpg.key'
property :rpm_key,          String, default:  'https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana'
property :deb_distribution, String, default:  'stable'
property :deb_components,   Array,  default:  ['main']

action :install do
  GrafanaCookbook::CookieHelper.grafana_version = new_resource.version if new_resource.version

  case node['platform_family']
  when 'debian'
    repository = "#{new_resource.repo}/deb"
  when 'rhel', 'amazon'
    repository = "#{new_resource.repo}/rpm"
  end

  case node['platform_family']
  when 'debian'
    package 'apt-transport-https' do
    end

    apt_repository 'grafana' do
      uri           repository
      distribution  new_resource.deb_distribution
      components    new_resource.deb_components
      key           new_resource.key
      cache_rebuild true
      trusted       false
    end

    # There is an issue on debian based systems which causes the error:
    # There were unauthenticated packages and -y was used without --allow-unauthenticated
    # this will allow grafana to be installed on 16.04 without compromising security of other systems
    package 'grafana' do
      options '-o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --allow-unauthenticated'
      version new_resource.version if new_resource.version
    end
  when 'rhel', 'amazon'
    yum_repository 'grafana' do
      description   'Grafana Repo'
      baseurl       repository
      gpgkey        "#{new_resource.key} #{new_resource.rpm_key}"
      gpgcheck      true
    end

    package 'grafana' do
      version new_resource.version if new_resource.version
    end

  end
end
