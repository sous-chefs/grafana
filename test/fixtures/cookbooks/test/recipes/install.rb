grafana_install 'grafana'

grafana_config 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end

grafana_config_session 'Grafana' do
  session_provider :memory
end

grafana_config_external_image_storage_s3 'Grafana' do
  storage_provider 's3'
  bucket 'grafana-image-store'
  region 'us-east-1'
end

grafana_config_date_formats 'Grafana' do
  use_browser_locale true
end

grafana_service 'grafana-server' do
  action %i(enable start)
  subscribes :restart, 'template[/etc/grafana/grafana.ini]', :delayed
end
