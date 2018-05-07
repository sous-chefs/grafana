actions :create, :update, :delete
default_action :create

# Grafana options
attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :admin_user, kind_of: String, default: 'admin'
attribute :admin_password, kind_of: String, default: 'admin'
# Resource properties
attribute :user, kind_of: Hash, default: {}
