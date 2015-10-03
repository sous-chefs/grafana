ldap = node['grafana']['ldap'].dup
verbose_logging = node['grafana']['ldap_verbose_logging']

template node['grafana']['ini']['auth.ldap']['config_file']['value'] do
  source 'ldap.toml.erb'
  variables verbose_logging: verbose_logging, config: ldap
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :delayed
end
