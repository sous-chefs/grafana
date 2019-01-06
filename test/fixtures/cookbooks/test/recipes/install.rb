grafana_install 'grafana' do
end

grafana_config 'Grafana' do
end
grafana_config_alerting 'Grafana' do
end
grafana_config_auth 'Grafana' do
end
grafana_config_dashboards 'Grafana' do
end
grafana_config_database 'Grafana' do
end
grafana_config_dataproxy 'Grafana' do
end
grafana_config_emails 'Grafana' do
end
grafana_config_enterprise 'Grafana' do
end
grafana_config_explore 'Grafana' do
end
grafana_config_log 'Grafana' do
end
grafana_config_metrics 'Grafana' do
end
grafana_config_panels 'Grafana' do
end
grafana_config_paths 'Grafana' do
end
grafana_config_quota 'Grafana' do
end
grafana_config_security 'Grafana' do
end
grafana_config_server 'Grafana' do
end
grafana_config_session 'Grafana' do
end
grafana_config_smtp 'Grafana' do
end
grafana_config_snapshots 'Grafana' do
end
grafana_config_users 'Grafana' do
end

service 'grafana-server' do
  supports start: true, stop: true, restart: true, status: true, reload: false
  action [:enable, :start]
end
