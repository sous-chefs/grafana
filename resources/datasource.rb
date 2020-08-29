#
# Cookbook:: grafana
# Resource:: datasource
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
property :datasource,     Hash,     default: {}

property :auth_proxy_header, [String, nil]

default_action :create

include GrafanaCookbook::DataSourceApi
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
  # If datasource name is not provided as variable,
  # Let's use resource name for it
  new_datasource = { name: new_resource.name }
  new_datasource.merge!(new_resource.datasource)

  _select_org(new_resource, grafana_options)

  datasources = get_datasource_list(grafana_options)
  exists = false

  datasources.each do |src|
    exists = true if src['name'] == new_datasource[:name]
    break if exists
  end

  # If not found, let's create it
  unless exists
    converge_by("Creating datasource #{new_datasource[:organization]} #{new_datasource[:name]}") do
      add_datasource(new_datasource, _legacy_http_semantic, grafana_options)
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
  # If datasource name is not provided as variable,
  # Let's use resource name for it
  new_datasource = { name: new_resource.name }
  new_datasource.merge!(new_resource.datasource)

  _select_org(new_resource, grafana_options)

  datasources = get_datasource_list(grafana_options)
  exists = false

  # Check whether we have to update datasource's login
  old_name = if new_datasource[:name] != new_resource.name
               new_resource.name
             else
               new_datasource[:name]
             end

  # Find wether datasource already exists
  # If found, update all informations we have to
  datasources.each do |src|
    if src['name'] == old_name
      exists = true
      new_datasource[:id] = src['id']
      converge_by("Updating datasource #{new_datasource[:name]}") do
        update_datasource(new_datasource, _legacy_http_semantic, grafana_options)
      end
    end
    break if exists
  end

  # If not found, let's create it
  unless exists
    Chef::Log.warn "Impossible to update datasource #{new_datasource[:name]} because it does not exist. We will create it."
    run_action(:create)
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
  # If datasource name is not provided as variable,
  # Let's use resource name for it
  new_datasource = { name: new_resource.name }
  new_datasource.merge!(new_resource.datasource)

  _select_org(new_resource, grafana_options)

  datasources = get_datasource_list(grafana_options)
  exists = false

  # Find wether datasource already exists
  # If found, delete it
  datasources.each do |src|
    next unless src['name'] == new_datasource[:name]
    exists = true
    new_datasource[:id] = src['id']
    converge_by("Deleting data source #{new_resource.name}") do
      delete_datasource(new_datasource, grafana_options)
    end
  end
end

def _legacy_http_semantic
  false
end

def _check_org!(datasource, orgs)
  return if orgs.length <= 1 || datasource.key?(:organization)
  raise 'More than one organization, so organization is mandatory for a datasource'
end

def _select_org(new_resource, grafana_options)
  # check, if we have multiple orgs, then the org is mandatory
  orgs = get_orgs_list(grafana_options)
  _check_org! new_resource.datasource, orgs

  # don't do anything if an organization is not selected
  return unless new_resource.datasource.key?(:organization)

  # Find organization by name
  selected_org = orgs.detect do |org|
    org['name'] == new_resource.datasource[:organization]
  end

  # If organization is provided select it
  unless selected_org
    raise "Could not find organization #{new_resource.datasource[:organization]}"
  end
  select_org(selected_org, grafana_options)
end
