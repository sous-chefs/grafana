grafana_install 'grafana'

service 'grafana-server' do
  action [:enable, :start]
  subscribes :restart, ['template[/etc/grafana/grafana.ini]', 'template[/etc/grafana/ldap.toml]'], :immediately
end

grafana_config 'Grafana'

grafana_config_auth 'Grafana' do
  ldap_enabled true
end

grafana_config_log 'Grafana'

grafana_config_ldap 'Grafana'

grafana_config_ldap_servers 'Grafana' do
  host            '127.0.0.1'
  port            389
  use_ssl         false
  start_tls       false
  ssl_skip_verify false
  bind_dn         'cn=admin,dc=grafana,dc=org'
  bind_password   'SuperSecretPassword'
  search_filter   '(cn=%s)'
  search_base_dns %w( dc=grafana,dc=org )
end

grafana_config_ldap_group_mappings 'Grafana' do
  group_dn      'cn=admins,dc=grafana,dc=org'
  org_role      'Admin'
  grafana_admin true
  org_id        1
end

grafana_config_ldap_group_mappings 'Grafana' do
  group_dn  'cn=readers,dc=grafana,dc=org'
  org_role  'Viewer'
end

grafana_config_writer 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end

# Stall to allow service to be fully available before testing
execute 'sleep 30' do
  action :nothing
  subscribes :run, 'service[grafana-server]', :immediately
end
