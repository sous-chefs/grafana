grafana_install 'grafana'

grafana_config 'Grafana'

grafana_config_auth 'Grafana' do
  disable_login_form false
  login_cookie_name 'grafana_session'
end

grafana_config_auth_proxy 'Grafana' do
  enabled true
  header_name 'X-WEBAUTH-USER'
  header_property 'username'
  whitelist '127.0.0.1, ::1'
end

grafana_config_dashboards 'Grafana' do
  versions_to_keep 2
  min_refresh_interval '3s'
end

grafana_config_unified_alerting 'Grafana' do
  enabled false
end

grafana_service 'grafana' do
  action %i(enable start)
  subscribes :restart, 'template[/etc/grafana/grafana.ini]', :delayed
end
