grafana_install 'grafana'

grafana_config 'Grafana'
grafana_config_alerting 'Grafana'
grafana_config_auth 'Grafana'
grafana_config_dashboards 'Grafana'
grafana_config_database 'Grafana'
grafana_config_dataproxy 'Grafana'
grafana_config_emails 'Grafana'
grafana_config_enterprise 'Grafana'
grafana_config_explore 'Grafana'
grafana_config_log 'Grafana'
grafana_config_metrics 'Grafana'
grafana_config_panels 'Grafana'
grafana_config_paths 'Grafana'
grafana_config_quota 'Grafana'
grafana_config_security 'Grafana'
grafana_config_server 'Grafana'
grafana_config_session 'Grafana' do
  session_provider 'memory'
end
grafana_config_remote_cache 'Grafana'
grafana_config_smtp 'Grafana'
grafana_config_snapshots 'Grafana'
grafana_config_users 'Grafana'
grafana_config_external_image_storage_s3 'Grafana' do
  storage_provider 's3'
  bucket 'grafana-image-store'
  region 'us-east-1'
end

# Stall to allow service to be fully available before testing
execute 'sleep 30' do
  action :nothing
  subscribes :run, 'service[grafana-server]', :immediately
end
