require 'chef/mash'

include GrafanaCookbook::OrganizationApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
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
    user: new_resource.admin_user,
    password: new_resource.admin_password,
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
    user: new_resource.admin_user,
    password: new_resource.admin_password,
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
