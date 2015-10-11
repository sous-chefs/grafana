actions :create, :update, :delete
default_action :create

state_attrs :name

# Grafana options
attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :admin_user, kind_of: String, default: 'admin'
attribute :admin_password, kind_of: String, default: 'admin'
# Resource properties
attribute :name, kind_of: String, required: true
attribute :dashboard, kind_of: Hash, default: {}
