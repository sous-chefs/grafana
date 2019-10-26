grafana_install 'grafana'

service 'grafana-server' do
  action [:enable, :start]
  subscribes :restart, ['template[/etc/grafana/grafana.ini]', 'template[/etc/grafana/ldap.toml]'], :delayed
end

directory '/etc/grafana'

grafana_config 'Grafana'

grafana_config_writer 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end
