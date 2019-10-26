grafana_install 'grafana'

service 'grafana-server' do
  action [:enable]
  subscribes :restart, ['template[/etc/grafana/grafana.ini]', 'template[/etc/grafana/ldap.toml]'], :immediately
end

grafana_config 'Grafana'

grafana_config_writer 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end
