#
# Cookbook:: grafana
# Resource:: dashboard
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
property :dashboard,      Hash,     default: {}

property :auth_proxy_header, [String, nil]

default_action :create

include GrafanaCookbook::DashboardApi
include GrafanaCookbook::OrganizationApi
include GrafanaCookbook::FolderApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    url_path_prefix: new_resource.url_path_prefix,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }
  # If dashboard's name, source, or cookbook is not provided as variable,
  # Let's use resource name for it
  new_dashboard = {
    name: new_resource.name,
    source: new_resource.name,
    cookbook: cookbook_name,
  }
  new_dashboard.merge!(new_resource.dashboard)

  same_folder_name = get_folder_by_name(new_resource.dashboard[:name], grafana_options)

  if (!same_folder_name.nil? && same_folder_name.key?(:message) && same_folder_name[:message] != 'Not found') || (!same_folder_name.nil? && same_folder_name.key?('url') && same_folder_name['url'].include?('/dashboards/f/'))
    Chef::Log.error "Folder exist with same name '#{get_folder_title(same_folder_name)}'"
    return
  end

  _select_org(new_resource, grafana_options)

  dashboard_sanity(new_dashboard)

  # Find wether dashboard already exists
  dash = get_dashboard(new_dashboard, grafana_options)

  # If not found, or if overwrite is set to true, let's create it
  if dash.nil? || new_dashboard[:overwrite]
    converge_by("Creating dashboard #{new_resource.name}") do
      create_update_dashboard(new_dashboard, grafana_options)
    end
  end
end

action :update do
  # If dashboard's name, source, or cookbook is not provided as variable,
  # Let's use resource name for it
  new_dashboard = {
    name: new_resource.name,
    source: new_resource.name,
    cookbook: cookbook_name,
  }
  new_dashboard.merge!(new_resource.dashboard)
  new_dashboard[:overwrite] = true

  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    url_path_prefix: new_resource.url_path_prefix,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }

  _select_org(new_resource, grafana_options)

  dashboard_sanity(new_dashboard)

  converge_by("Updating dashboard #{new_resource.name}") do
    create_update_dashboard(new_dashboard, grafana_options)
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
  # If dashboard's name, source, or cookbook is not provided as variable,
  # Let's use resource name for it
  new_dashboard = {
    name: new_resource.name,
    source: new_resource.name,
    cookbook: cookbook_name,
  }
  new_dashboard.merge!(new_resource.dashboard)

  _select_org(new_resource, grafana_options)

  dashboard_sanity(new_resource.dashboard)

  # Find wether dashboard already exists
  dash = get_dashboard(new_dashboard, grafana_options)

  # If found, just delete it
  unless dash.nil?
    converge_by("Removing dashboard #{new_resource.name}") do
      delete_dashboard(new_dashboard, grafana_options)
    end
  end
end

def _check_org!(dashboard, orgs)
  return if orgs.length <= 1 || dashboard.key?(:organization)
  raise 'More than one organization, so organization is mandatory for a dashboard'
end

def _select_org(new_resource, grafana_options)
  # check, if we have multiple orgs, then the org is mandatory
  orgs = get_orgs_list(grafana_options)
  _check_org! new_resource.dashboard, orgs

  # don't do anything if an organization is not selected
  return unless new_resource.dashboard.key?(:organization)

  # Find organization by name
  selected_org = orgs.detect do |org|
    org['name'] == new_resource.dashboard[:organization]
  end

  # If organization is provided select it
  unless selected_org
    raise "Could not find organization #{new_resource.dashboard[:organization]}"
  end
  select_org(selected_org, grafana_options)
end
