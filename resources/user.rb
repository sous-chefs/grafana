actions :create_if_missing, :update, :delete
default_action :create_if_missing

state_attrs :login,
  :admin

# Grafana options
attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :admin_user, kind_of: String, default: 'admin'
attribute :admin_password, kind_of: String, default: 'admin'
# Resource properties
attribute :name, kind_of: String, required: true
attribute :user, kind_of: Hash, default: {}
