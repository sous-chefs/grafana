actions :install, :update, :remove
default_action :install

# Resource properties
attribute :grafana_cli_bin, kind_of: String, required: false, default: '/usr/sbin/grafana-cli'

attr_accessor :installed
