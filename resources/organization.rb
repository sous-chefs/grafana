actions :create_if_missing
default_action :create_if_missing

attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :user, kind_of: String, default: 'admin'
attribute :password, kind_of: String, default: 'admin'
attribute :name, kind_of: String, name_attribute: true, required: true
