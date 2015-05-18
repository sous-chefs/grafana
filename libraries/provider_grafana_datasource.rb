require 'chef/provider/lwrp_base'
require_relative 'DatasourceApi'

class Chef
  class Provider
    class GrafanaDatasource < Chef::Provider::LWRPBase
      include GrafanaCookbook::DataSourceApi

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :create do
        new_resource.source[:name] = new_resource.source_name
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
            new_resource.source[:orgId] = src['orgId']
          end
        end

        if exists
          update_data_source(new_resource.source, grafana_options)
        else
          add_data_source(new_resource.source, grafana_options)
          Chef::Log.info "Added #{new_resource.source_name} as a datasource to Grafana"
        end
        new_resource.updated_by_last_action(true)
      end

      action :create_if_missing do
        new_resource.source[:name] = new_resource.source_name
        grafana_options = {
          host: new_resource.host,
          port: new_resource.port,
          user: new_resource.user,
          password: new_resource.password
        }
        datasources = get_data_source_list(grafana_options)

        exists = false
        datasources.each do |src|
          exists = true if src['name'] == new_resource.source_name
        end

        if !exists
          add_data_source(new_resource.source, grafana_options)
          Chef::Log.info "Added #{new_resource.source_name} as a datasource to Grafana"
          new_resource.updated_by_last_action(true)
        else
          Chef::Log.info "#{new_resource.source_name} exists, nothing to update!"
        end
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
          delete_data_source(new_resource.source[:id], grafana_options)
          Chef::Log.info "Deleted datasource #{new_resource.source_name} (id: #{new_resource.source[:id]}) from Grafana"
          new_resource.updated_by_last_action(true)
        else
          Chef::Log.info "#{new_resource.source_name} did not exist, nothing deleted!"
        end
      end
    end
  end
end
