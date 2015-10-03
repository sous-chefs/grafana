require 'chef/mash'

include GrafanaCookbook::OrganizationApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create_if_missing do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  orgs = get_orgs_list(grafana_options)

  new_resource.organization[:name] = new_resource.name
  exists = false
  orgs.each do |org|
    exists = true if org['name'] == new_resource.name
  end
  unless exists
    converge_by("Creating organization #{new_resource.name}") do
      add_org(new_resource.organization, grafana_options)
    end
  end
end

action :update do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  orgs = get_orgs_list(grafana_options)

  exists = false
  orgs.each do |org|
    if org['name'] == new_resource.name
      exists = true
      new_resource.organization[:id] = org['id']
    end
  end
  if exists
    converge_by("Updating organization #{new_resource.name}") do
      update_org(new_resource.organization, grafana_options)
    end
  end
end

action :delete do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  orgs = get_orgs_list(grafana_options)

  Chef::Log.warn "Looking for organization #{new_resource.name}"
  Chef::Log.warn "in " + orgs.to_s
  exists = false
  orgs.each do |org|
    if org['name'] == new_resource.name
      exists = true
      Chef::Log.warn "Found organization " + org.to_s
      new_resource.organization[:id] = org['id']
      converge_by("Deleting organization #{new_resource.name}") do
        delete_org(new_resource.organization, grafana_options)
      end
    end
  end
end
