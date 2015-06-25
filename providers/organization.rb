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

  exists = false
  orgs.each do |org|
    exists = true if org['name'] == new_resource.name
  end
  unless exists
    converge_by("Creating organization #{new_resource.name}") do
      add_org(new_resource.name, grafana_options)
    end
  end
end
