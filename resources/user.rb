actions :create_if_missing
default_action :create_if_missing

state_attrs :login,
  :admin

attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :user, kind_of: String, default: 'admin'
attribute :password, kind_of: String, default: 'admin'
attribute :global, kind_of: [TrueClass, FalseClass], default: true
attribute :admin, kind_of: [TrueClass, FalseClass], default: false
attribute :login, kind_of: String, name_attribute: true, required: true
attribute :full_name, kind_of: String, required: true
attribute :email, kind_of: String, required: true
attribute :passwd, kind_of: String, required: true
