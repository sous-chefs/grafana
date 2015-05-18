require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class GrafanaDatasource < Chef::Resource::LWRPBase
      self.resource_name = :grafana_datasource
      actions :create, :create_if_missing, :delete
      default_action :create

      attribute :host, kind_of: String, default: 'localhost'
      attribute :port, kind_of: String, default: '3000'
      attribute :user, kind_of: String, default: 'admin'
      attribute :password, kind_of: String, default: 'admin'
      attribute :source_name, kind_of: String, name_attribute: true, required: true
      # Something like this:
      # source(
      #   type: 'influxdb_08',
      #   url: 'http://10.0.0.10:8086',
      #   access: 'direct',
      #   database: 'metrics',
      #   user: 'dashboard',
      #   password: 'dashpass'
      # )
      attribute :source, kind_of: Hash, default: {}
    end
  end
end
