require 'chef/provider/lwrp_base'
require_relative 'dashboard_api'

class Chef
  class Provider
    class GrafanaDashboard < Chef::Provider::LWRPBase
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
        # do some logic
        create_dashboard(nil, grafana_options)
      end

      action :create_if_missing do
        Chef::Log.fatal 'grafana_dashboard create_if_missing is not implemented!'
      end

      action :delete do
        Chef::Log.fatal 'grafana_dashboard delete is not implemented!'
      end
    end
  end
end
