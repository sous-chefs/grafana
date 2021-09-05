grafana_install 'grafana'

grafana_config 'Grafana'

grafana_config_auth 'Grafana' do
  disable_login_form false
  proxy_enabled true
  proxy_header_name 'X-WEBAUTH-USER'
  proxy_header_property 'username'
  proxy_whitelist '127.0.0.1, ::1'
  login_cookie_name 'grafana_session'
end

grafana_config_dashboards 'Grafana' do
  versions_to_keep 2
  min_refresh_interval '3s'
end

grafana_service 'grafana' do
  action %i(enable start)
  subscribes :restart, 'template[/etc/grafana/grafana.ini]', :delayed
end
