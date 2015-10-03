actions :create_if_missing, :update, :delete
default_action :create_if_missing

state_attrs :organization_name

attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :user, kind_of: String, default: 'admin'
attribute :password, kind_of: String, default: 'admin'
attribute :name, kind_of: String, required: true
attribute :organization, kind_of: Hash, default: {}
