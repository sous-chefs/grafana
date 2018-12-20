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

  puts "\n#{get_dashboard({name: new_resource.folder[:title]}, grafana_options).to_json}"
  return if get_dashboard({name: new_resource.folder[:title]}, grafana_options)

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
      new_resource.folder[:id] = src['id']
      new_resource.folder[:uid] = src['uid']
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
    next unless src['title'] == new_resource.folder[:title]
    exists = true
    new_resource.folder[:id] = src['id']
    new_resource.folder[:uid] = src['uid']
    converge_by("Deleting folder #{new_resource.name}") do
      delete_folder(new_resource.folder, grafana_options)
    end
  end
end

def _legacy_http_semantic
  return false if node['grafana']['version'] == 'latest'
  Gem::Version.new(node['grafana']['version']) < Gem::Version.new('2.0.3')
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
