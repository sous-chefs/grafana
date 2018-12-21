# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
property :host,           String,   default: 'localhost'
property :port,           Integer,  default: 3000
property :admin_user,     String,   default: 'admin'
property :admin_password, String,   default: 'admin'
property :folder,     Hash,     default: {}

default_action :create

include GrafanaCookbook::FolderApi
include GrafanaCookbook::DashboardApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
  }

  # If folder name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.folder.key?(:title)
    new_resource.folder[:title] = new_resource.name
  end

  same_dashboard_name = get_dashboard({name: new_resource.folder[:title]}, grafana_options)

  if ((not same_dashboard_name.nil?) and same_dashboard_name.key?(:message) and same_dashboard_name[:message] != "Not found") or ((not same_dashboard_name.nil?) and same_dashboard_name.key?('meta') and same_dashboard_name.key?('dashboard') and same_dashboard_name['meta'].key?('url') and same_dashboard_name['dashboard'].key?('uid') and same_dashboard_name['meta']['url'].include?("/d/" + same_dashboard_name['dashboard']['uid']))
    Chef::Log.error "A dashboard exist with same name '#{same_dashboard_name['dashboard']['title']}'"
    return
  end

  # _select_org(new_resource, grafana_options)

  folders = get_folders(grafana_options)
  exists = false

  folders.each do |src|
    exists = true if src['title'] == new_resource.folder[:title]
    break if exists
  end

  # If not found, let's create it
  unless exists
    converge_by("Creating folder #{new_resource.folder[:title]}") do
      create_folder(new_resource.folder, grafana_options)
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
  # If folder name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.folder.key?(:title)
    new_resource.folder[:title] = new_resource.name
  end

  # _select_org(new_resource, grafana_options)

  folders = get_folders(grafana_options)
  exists = false

  # Check wether we have to update folder's login
  old_name = if new_resource.folder[:title] != new_resource.name
               new_resource.name
             else
               new_resource.folder[:title]
             end

  # Find wether folder already exists
  # If found, update all informations we have to
  folders.each do |src|
    if src['title'] == old_name
      exists = true
      new_resource.folder[:id] = get_folder_id(src)
      new_resource.folder[:uid] = get_folder_uid(src)
      converge_by("Updating folder #{new_resource.folder[:title]}") do
        update_folder(new_resource.folder, grafana_options)
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
  # If folder name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.folder.key?(:title)
    new_resource.folder[:title] = new_resource.name
  end

  # _select_org(new_resource, grafana_options)

  folders = get_folders(grafana_options)
  exists = false

  # Find wether folder already exists
  # If found, delete it
  folders.each do |src|
    next unless get_folder_title(src) == new_resource.folder[:title]
    exists = true
    new_resource.folder[:id] = get_folder_id(src)
    new_resource.folder[:uid] = get_folder_uid(src)
    converge_by("Deleting folder #{new_resource.name}") do
      delete_folder(new_resource.folder, grafana_options)
    end
  end
end
