#
# Cookbook:: grafana
# Resource:: user
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
property :user,           Hash,     default: {}

property :auth_proxy_header, [String, nil]

default_action :create

include GrafanaCookbook::UserApi
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
  # If login is not provided as variable,
  # Let's use resource name for it
  new_user = { login: new_resource.name }
  new_user.merge!(new_resource.user)

  users_list = get_user_list(grafana_options)
  exists = false

  # Find wether user already exists
  users_list.each do |user|
    exists = true if user['login'] == new_user[:login]
    break if exists
  end

  # If not found, let's create it and set its permissions
  unless exists
    new_user[:name] = new_resource.name
    converge_by("Creating user #{new_user[:login]}") do
      add_user(new_user, grafana_options)
    end
    new_users_list = get_user_list(grafana_options)
    new_users_list.each do |n_user|
      n_user['login'] == new_user[:login] && new_user[:id] = n_user['id']
    end
    converge_by("Setting permissions #{new_user[:login]}") do
      update_user_permissions(new_user, grafana_options)
    end
    if new_user.key?(:organizations)
      converge_by("Adding user to organizations #{new_user[:organizations].map { |org| org[:name] }}") do
        add_user_to_orgs(new_user, grafana_options)
      end
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
  # If login is not provided as variable,
  # Let's use resource name for it
  new_user = { login: new_resource.name }
  new_user.merge!(new_resource.user)

  users_list = get_user_list(grafana_options)
  exists = false

  # Check wether we have to update user's login
  old_login = if new_user[:login] != new_resource.name
                new_resource.name
              else
                new_user[:login]
              end

  # Find wether user already exists
  # If found, update all informations we have to
  users_list.each do |user|
    if user['login'] == old_login
      exists = true
      new_user[:id] = user['id']
      converge_by("Updating details for user #{new_user[:login]}") do
        update_user_details(new_user, grafana_options)
      end
      converge_by("Updating password for user #{new_user[:login]}") do
        update_user_password(new_user, grafana_options)
      end
      if new_user[:isAdmin] != user['isAdmin'] && !new_user[:isAdmin].nil?
        converge_by("Updating permissions for user #{new_user[:login]}") do
          update_user_permissions(new_user, grafana_options)
        end
      end
      if new_user.key?(:organizations)
        converge_by("Updating user organizations #{new_user[:organizations].map { |org| org[:name] }}") do
          update_user_orgs(new_user, grafana_options)
        end
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
  # If login is not provided as variable,
  # Let's use resource name for it
  new_user = { login: new_resource.name }
  new_user.merge!(new_resource.user)

  users_list = get_user_list(grafana_options)
  exists = false

  # Find wether use already exists
  # If found, just delete it
  users_list.each do |user|
    if user['login'] == new_user[:login]
      exists = true
      new_user[:id] = user['id']
      new_user[:name] = new_resource.name
      converge_by("Deleting user #{new_user[:login]}") do
        delete_user(new_user, grafana_options)
      end
    end
    break if exists
  end
end
