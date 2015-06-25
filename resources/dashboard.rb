actions :create, :create_if_missing, :delete
default_action :create_if_missing

state_attrs :source_name

attribute :host, kind_of: String, default: 'localhost'
attribute :port, kind_of: Integer, default: 3000
attribute :user, kind_of: String, default: 'admin'
attribute :password, kind_of: String, default: 'admin'
attribute :source_name, kind_of: String, name_attribute: true, required: true
attribute :source, kind_of: String, default: nil
attribute :cookbook, kind_of: String, default: nil
attribute :path, kind_of: String, default: nil
attribute :overwrite, kind_of: [TrueClass, FalseClass], default: true
# attribute :dashboard, kind_of: Hash, default: Hash.new
