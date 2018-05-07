actions :create, :update, :delete
default_action :create

attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :admin_user, kind_of: String, default: 'admin'
attribute :admin_password, kind_of: String, default: 'admin'
attribute :datasource, kind_of: Hash, default: {}
