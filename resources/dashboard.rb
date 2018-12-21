property :host,           String,   default: 'localhost'
property :port,           Integer,  default: 3000
property :admin_user,     String,   default: 'admin'
property :admin_password, String,   default: 'admin'
property :dashboard,      Hash,     default: {}

default_action :create

include GrafanaCookbook::DashboardApi
include GrafanaCookbook::OrganizationApi
include GrafanaCookbook::FolderApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
  }
  # If dashboard's name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:name)
    new_resource.dashboard[:name] = new_resource.name
  end

  same_folder_name = get_folder_by_name(new_resource.dashboard[:name], grafana_options)

  if ((not same_folder_name.nil?) and same_folder_name.key?(:message) and same_folder_name[:message] != "Not found") or ((not same_folder_name.nil?) and same_folder_name.key?('url') and same_folder_name['url'].include?("/dashboards/f/"))
    Chef::Log.error "Folder exist with same name '#{get_folder_title(same_folder_name)}'"
    return
  end

  _select_org(new_resource, grafana_options)

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
    password: new_resource.admin_password,
  }
  # If dashboard's name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:name)
    new_resource.dashboard[:name] = new_resource.name
  end

  _select_org(new_resource, grafana_options)

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
    password: new_resource.admin_password,
  }
  # If dashboard's name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.dashboard.key?(:name)
    new_resource.dashboard[:name] = new_resource.name
  end

  _select_org(new_resource, grafana_options)

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
