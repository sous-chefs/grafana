ldap = node['grafana']['ldap'].dup
verbose_logging = node['grafana']['ldap_verbose_logging']
multi_tree_auth = node['grafana']['ldap_multi_tree_auth']

template node['grafana']['ini']['auth.ldap']['config_file']['value'] do
  source 'ldap.toml.erb'
  variables verbose_logging: verbose_logging, config: ldap, multi_config: multi_tree_auth
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :delayed
end
