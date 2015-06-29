include GrafanaCookbook::DashboardApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  source = new_resource.source_name
  source = new_resource.source unless new_resource.source.nil?
  dash_hash = {
    name: new_resource.source_name,
    source: source,
    cookbook: new_resource.cookbook.nil? ? cookbook_name : new_resource.cookbook,
    path: new_resource.path,
    overwrite: new_resource.overwrite
  }
  dashboard_sanity(dash_hash)
  converge_by("Creating dashboard #{new_resource.name}") do
    create_dashboard(dash_hash, grafana_options)
  end
end

action :create_if_missing do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  source = new_resource.source_name
  source = new_resource.source unless new_resource.source.nil?
  dash_hash = {
    name: new_resource.source_name,
    source: source,
    cookbook: new_resource.cookbook.nil? ? cookbook_name : new_resource.cookbook,
    path: new_resource.path,
    overwrite: new_resource.overwrite
  }
  dashboard_sanity(dash_hash)
  dash = get_dashboard(dash_hash, grafana_options)
  if dash['message'] == 'Dashboard not found'
    converge_by("Creating dashboard #{new_resource.name}") do
      create_dashboard(dash_hash, grafana_options)
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
  dash = get_dashboard({ name: new_resource.source_name }, grafana_options)
  unless dash['message'] == 'Dashboard not found'
    converge_by("Removing dashboard #{new_resource.name}") do
      delete_dashboard(new_resource.source_name, grafana_options)
    end
  end
end
