#
# Cookbook:: grafana
# Resource:: organization
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

property :host,           String,   default: 'localhost'
property :port,           Integer,  default: 3000
property :url_path_prefix, String
property :admin_user,     String,   default: 'admin'
property :admin_password, String,   default: 'admin'
property :organization,   Hash,     default: {}

property :auth_proxy_header, [String, nil]

default_action :create

include GrafanaCookbook::OrganizationApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    url_path_prefix: new_resource.url_path_prefix,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }
  # If name is not provided as variable,
  # Let's use resource name for it
  new_organization = { name: new_resource.name }
  new_organization.merge!(new_resource.organization)

  orgs = get_orgs_list(grafana_options)
  exists = false

  # Find wether organization already exists
  orgs.each do |org|
    exists = true if org['name'] == new_organization[:name]
    break if exists
  end
  unless exists
    converge_by("Creating organization #{new_resource.name}") do
      add_org(new_organization, grafana_options)
    end
  end
end

action :update do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    url_path_prefix: new_resource.url_path_prefix,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }
  # If name is not provided as variable,
  # Let's use resource name for it
  new_organization = { name: new_resource.name }
  new_organization.merge!(new_resource.organization)

  orgs = get_orgs_list(grafana_options)
  exists = false

  # Check wether we have to update user's login
  old_login = if new_organization[:name] != new_resource.name
                new_resource.name
              else
                new_organization[:name]
              end

  orgs.each do |org|
    if org['name'] == old_login
      exists = true
      new_organization[:id] = org['id']
      converge_by("Updating organization #{new_resource.name}") do
        update_org(new_organization, grafana_options)
      end
    end
    break if exists
  end
end

action :delete do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    url_path_prefix: new_resource.url_path_prefix,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }
  # If name is not provided as variable,
  # Let's use resource name for it
  new_organization = { name: new_resource.name }
  new_organization.merge!(new_resource.organization)

  orgs = get_orgs_list(grafana_options)
  exists = false

  orgs.each do |org|
    if org['name'] == new_organization[:name]
      exists = true
      new_organization[:id] = org['id']
      converge_by("Deleting organization #{new_organization[:name]}") do
        delete_org(new_organization, grafana_options)
      end
    end
    break if exists
  end
end
