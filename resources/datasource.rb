actions :create, :create_if_missing, :delete
default_action :create

state_attrs :source_name

attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :user, kind_of: String, default: 'admin'
attribute :password, kind_of: String, default: 'admin'
attribute :source_name, kind_of: String, name_attribute: true, required: true
attribute :source, kind_of: Hash, default: {}
