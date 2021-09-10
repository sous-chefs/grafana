grafana_install 'grafana'

grafana_config 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end

grafana_config_auth 'Grafana'

grafana_config_auth_ldap 'Grafana' do
  sensitive false

  enabled true
end

grafana_config_log 'Grafana' do
  sensitive false

  level 'info'
  mode 'console file'
end

grafana_config_log_file 'Grafana' do
  sensitive false

  daily_rotate true
end

grafana_config_ldap_server 'Grafana' do
  sensitive false

  host '127.0.0.1'
  port 389
  use_ssl false
  start_tls false
  ssl_skip_verify false
  bind_dn 'cn=admin,dc=grafana,dc=org'
  bind_password 'SuperSecretPassword'
  search_filter '(cn=%s)'
  search_base_dns %w( dc=grafana,dc=org )
end

grafana_config_ldap_attributes '127.0.0.1'

grafana_config_ldap_group_mapping 'cn=admins,dc=grafana,dc=org' do
  host '127.0.0.1'
  org_role 'Admin'
  grafana_admin true
  org_id 1
end

grafana_config_ldap_group_mapping 'readers' do
  host '127.0.0.1'
  group_dn 'cn=readers,dc=grafana,dc=org'
  org_role 'Viewer'
  grafana_admin false
  org_id 1
end

grafana_service 'grafana-server' do
  action %i(enable start)
  subscribes :restart, 'template[/etc/grafana/grafana.ini]', :delayed
end
