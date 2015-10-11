require 'chef/mash'

include GrafanaCookbook::DashboardApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  # If dashboard's name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:name)
    new_resource.dashboard[:name] = new_resource.name
  end
  # If dashboard source is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:source)
    new_resource.dashboard[:source] = new_resource.name
  end
  # If dashboard cookbook is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:cookbook)
    new_resource.dashboard[:cookbook] = cookbook_name
  end
  dashboard_sanity(new_resource.dashboard)

  # Find wether dashboard already exists
  dash = get_dashboard(new_resource.dashboard, grafana_options)

  # If not found, or if overwrite is set to true, let's create it
  if dash.nil? || new_resource.dashboard[:overwrite]
    converge_by("Creating dashboard #{new_resource.name}") do
      create_update_dashboard(new_resource.dashboard, grafana_options)
    end
  end
end

action :update do
  new_resource.dashboard[:overwrite] = true

  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  # If dashboard's name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:name)
    new_resource.dashboard[:name] = new_resource.name
  end
  # If dashboard source is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:source)
    new_resource.dashboard[:source] = new_resource.name
  end
  # If dashboard cookbook is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:cookbook)
    new_resource.dashboard[:cookbook] = cookbook_name
  end
  dashboard_sanity(new_resource.dashboard)

  # Find wether dashboard already exists
  dash = get_dashboard(new_resource.dashboard, grafana_options)

  # If not found, or if overwrite is set to true, let's update it
  if dash.nil? || new_resource.dashboard[:overwrite]
    converge_by("Updating dashboard #{new_resource.name}") do
      create_update_dashboard(new_resource.dashboard, grafana_options)
    end
  end
end

action :delete do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  # If dashboard's name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:name)
    new_resource.dashboard[:name] = new_resource.name
  end
  # If dashboard source is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:source)
    new_resource.dashboard[:source] = new_resource.name
  end
  # If dashboard cookbook is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:cookbook)
    new_resource.dashboard[:cookbook] = cookbook_name
  end
  dashboard_sanity(new_resource.dashboard)

  # Find wether dashboard already exists
  dash = get_dashboard(new_resource.dashboard, grafana_options)

  # If found, just delete it
  unless dash.nil?
    converge_by("Removing dashboard #{new_resource.name}") do
      delete_dashboard(new_resource.dashboard, grafana_options)
    end
  end
end
