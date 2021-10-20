grafana_install 'grafana'

grafana_config 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end

grafana_config_auth_azuread 'Test Azure AD' do
  enabled true
  allow_sign_up true
  client_id 'test_id'
  client_secret 'test_secret'
  auth_url 'https://login.microsoftonline.com/12345/oauth2/authorize'
  token_url 'https://login.microsoftonline.com/12345/oauth2/token'
  scopes 'openid email name groups'
  allowed_domains 'test.local'
  allowed_groups '8bab1c86-8fba-33e5-2089-1d1c80ec267e'
end

grafana_service 'grafana' do
  delay_start true
  action %i(enable start)
  subscribes :restart, 'template[/etc/grafana/grafana.ini]', :delayed
end
