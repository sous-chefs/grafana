require 'chef/provider/lwrp_base'
require_relative 'dashboard_api'

class Chef
  class Provider
    class GrafanaDashboard < Chef::Provider::LWRPBase
      provides :grafana_dashboard
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
          overwrite: new_resource.overwrite
        }
        dashboard_sanity(dash_hash)
        create_dashboard(dash_hash, grafana_options)
        new_resource.updated_by_last_action(true)
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
          overwrite: new_resource.overwrite
        }
        dashboard_sanity(dash_hash)
        dash = get_dashboard(dash_hash, grafana_options)
        # puts "dash is #{dash}"
        if dash['message'] == 'Dashboard not found'
          create_dashboard(dash_hash, grafana_options)
          new_resource.updated_by_last_action(true)
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
          delete_dashboard(new_resource.source_name, grafana_options)
          new_resource.updated_by_last_action(true)
        end
      end
    end
  end
end
