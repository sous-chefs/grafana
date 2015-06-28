require 'chef/mash'

include GrafanaCookbook::DataSourceApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  create(true)
end

action :create_if_missing do
  create(false)
end

def create(allow_update)
  new_resource.source[:name] = new_resource.source_name
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  datasources = get_data_source_list(grafana_options)

  exists = false
  should_update = true
  datasources.each do |src|
    if src['name'] == new_resource.source_name
      exists = true
      new_resource.source[:id] = src['id']
      new_resource.source[:orgId] = src['orgId']
      should_update = Mash.new(new_resource.source) != Mash.new(src)
    end
  end

  do_create exists, allow_update, should_update, grafana_options
end

def do_create(exists, allow_update, should_update, grafana_options)
  if exists
    if allow_update
      if should_update
        converge_by("Updating data source #{new_resource.name}") do
          update_data_source(new_resource.source, legacy_http_semantic, grafana_options)
        end
      else
        Chef::Log.info "#{new_resource.source_name} already up to date, nothing to update!"
      end
    else
      Chef::Log.info "#{new_resource.source_name} exists, nothing to update!"
    end
  else
    converge_by("Creating data source #{new_resource.name}") do
      add_data_source(new_resource.source, legacy_http_semantic, grafana_options)
    end
    Chef::Log.info "Added #{new_resource.source_name} as a datasource to Grafana"
  end
end

def legacy_http_semantic
  Gem::Version.new(node['grafana']['version']) < Gem::Version.new('2.0.3')
end

action :delete do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  datasources = get_data_source_list(grafana_options)

  exists = false
  datasources.each do |src|
    if src['name'] == new_resource.source_name
      exists = true
      new_resource.source[:id] = src['id']
    end
  end

  if exists
    converge_by("Deleting data source #{new_resource.name}") do
      delete_data_source(new_resource.source[:id], grafana_options)
    end
    Chef::Log.info "Deleted datasource #{new_resource.source_name} (id: #{new_resource.source[:id]}) from Grafana"
  else
    Chef::Log.info "#{new_resource.source_name} did not exist, nothing deleted!"
  end
end
