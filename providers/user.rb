require 'chef/mash'

include GrafanaCookbook::UserApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create_if_missing do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  users_list = get_user_list(grafana_options)
  exists = false

  users_list.each do |user|
    if user['login'] == new_resource.user[:login]
      exists = true
    end
    break if exists
  end
  unless exists
    new_resource.user[:name] = new_resource.name
    converge_by("Creating user #{new_resource.user[:login]}") do
      add_user(new_resource.user, grafana_options)
    end
    converge_by("Setting permissions #{new_resource.user[:login]}") do
      update_user_permission(new_resource.user, grafana_options)
    end

  end
end

action :update do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  users_list = get_user_list(grafana_options)
  exists = false

  if new_resource.user[:login] != new_resource.name
    old_login = new_resource.name
    new_login = new_resource.user[:login]
  else
    old_login = new_login = new_resource.user[:login]
  end
  users_list.each do |user|
    if user['login'] == old_login
      exists = true
      new_resource.user[:id] = user['id']
      converge_by("Updating details for user #{new_resource.user[:login]}") do
        update_user_details(new_resource.user, grafana_options)
      end
      converge_by("Updating password for user #{new_resource.user[:login]}") do
        update_user_password(new_resource.user, grafana_options)
      end
      if new_resource.user[:isAdmin] != user['isAdmin']
        converge_by("Updating permissions for user #{new_resource.user[:login]}") do
          update_user_permissions(new_resource.user, grafana_options)
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
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  users_list = get_user_list(grafana_options)
  exists = false

  users_list.each do |user|
    if user['login'] == new_resource.user[:login]
      exists = true
      new_resource.user[:id] = user['id']
      new_resource.user[:name] = new_resource.name
      converge_by("Deleting user #{new_resource.user[:login]}") do
        delete_user(new_resource.user, grafana_options)
      end
    end
    break if exists
  end
end
