# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
property :host,           String,   default: 'localhost'
property :port,           Integer,  default: 3000
property :url_path_prefix, String
property :admin_user,     String,   default: 'admin'
property :admin_password, String,   default: 'admin'
property :folder,         Hash,     default: {}

property :auth_proxy_header, [String, nil]

default_action :create

include GrafanaCookbook::FolderApi
include GrafanaCookbook::DashboardApi
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
  # If folder's name is not provided as variable,
  # Let's use resource name for it
  new_folder = {
    title: new_resource.name,
  }
  new_folder.merge!(new_resource.folder)

  _select_org(new_resource, grafana_options)

  same_dashboard_name = get_dashboard({ name: new_folder[:title] }, grafana_options)

  if (!same_dashboard_name.nil? && same_dashboard_name.key?(:message) && same_dashboard_name[:message] != 'Not found') || (!same_dashboard_name.nil? && same_dashboard_name.key?('meta') && same_dashboard_name.key?('dashboard') && same_dashboard_name['meta'].key?('url') && same_dashboard_name['dashboard'].key?('uid') && same_dashboard_name['meta']['url'].include?('/d/' + same_dashboard_name['dashboard']['uid']))
    Chef::Log.error "A dashboard exist with same name '#{same_dashboard_name['dashboard']['title']}'"
    return
  end

  folder = get_folder_by_name(new_folder[:title], grafana_options)

  # If not found, let's create it
  if folder.nil?
    converge_by("Creating folder #{new_folder[:title]}") do
      create_folder(new_folder, grafana_options)
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
  # If folder's name is not provided as variable,
  # Let's use resource name for it
  new_folder = {
    title: new_resource.name,
  }
  new_folder.merge!(new_resource.folder)
  new_folder[:overwrite] = true unless new_folder[:version]

  _select_org(new_resource, grafana_options)

  # Check wether we have to update folder's names
  update_folder = new_folder[:title] != new_resource.name
  folder = if update_folder
             get_folder_by_name(new_resource.name, grafana_options)
           else
             get_folder_by_name(new_folder[:title], grafana_options)
           end

  # TODO: Actually validate permissions need updating
  # permissions = get_folder_permissions(folder, grafana_options)
  update_perms = true
  if folder.nil?
    Chef::Log.warn "Impossible to update folder #{new_folder[:title]} because it does not exist. We will create it."
    run_action(:create)
  elsif update_folder || update_perms
    new_folder[:id] = get_folder_id(folder)
    new_folder[:uid] = get_folder_uid(folder)
    converge_by("Updating folder #{new_folder[:title]}") do
      update_folder(new_folder, grafana_options)
    end
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
  # If folder's name is not provided as variable,
  # Let's use resource name for it
  new_folder = {
    title: new_resource.name,
  }
  new_folder.merge!(new_resource.folder)

  _select_org(new_resource, grafana_options)

  folder = get_folder_by_name(new_folder[:title], grafana_options)

  new_folder[:id] = get_folder_id(folder)
  new_folder[:uid] = get_folder_uid(folder)
  converge_by("Deleting folder #{new_folder[:title]}") do
    delete_folder(new_folder, grafana_options)
  end
end

def _check_org!(folder, orgs)
  return if orgs.length <= 1 || folder.key?(:organization)
  raise 'More than one organization, so organization is mandatory for a folder'
end

def _select_org(new_resource, grafana_options)
  # check, if we have multiple orgs, then the org is mandatory
  orgs = get_orgs_list(grafana_options)
  _check_org! new_resource.folder, orgs

  # don't do anything if an organization is not selected
  return unless new_resource.folder.key?(:organization)

  # Find organization by name
  selected_org = orgs.detect do |org|
    org['name'] == new_resource.folder[:organization]
  end

  # If organization is provided select it
  unless selected_org
    raise "Could not find organization #{new_resource.folder[:organization]}"
  end
  select_org(selected_org, grafana_options)
end
