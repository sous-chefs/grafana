require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class GrafanaDashboard < Chef::Resource::LWRPBase
      self.resource_name = :grafana_dashboard
      actions :create, :create_if_missing, :delete
      default_action :create

      attribute :host, kind_of: String, default: 'localhost'
      attribute :port, kind_of: String, default: '3000'
      attribute :user, kind_of: String, default: 'admin'
      attribute :password, kind_of: String, default: 'admin'
      attribute :dashboard_name, kind_of: String, name_attribute: true, required: true
      # attribute :dashboard, kind_of: Hash, default: Hash.new
    end
  end
end
