ldap = node['grafana']['ldap'].dup
verbose_logging = node['grafana']['ldap_verbose_logging']

data_bag_name = node['grafana']['data_bag']['name']
config_item = node['grafana']['data_bag']['config_item']
grafana_config = GrafanaCookbook::Helper.data_bag_item(data_bag_name, config_item, missing_ok=true)

ini = Chef::Mixin::DeepMerge.merge(ldap, grafana_config)

template node['grafana']['ini']['auth.ldap']['config_file']['value'] do
  source 'ldap.toml.erb'
  variables verbose_logging: verbose_logging, config: ini
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[grafana-server]', :delayed
end
