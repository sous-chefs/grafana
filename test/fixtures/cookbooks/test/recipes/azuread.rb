grafana_install 'grafana'

grafana_config 'Grafana'

grafana_config_log 'Grafana'

grafana_config_auth_azuread 'Grafana' do
  auth_name 'Test Azure AD'
  enabled true
  allow_sign_up true
  client_id 'test_id'
  client_secret 'test_secret'
  auth_url 'https://login.microsoftonline.com/12345/oauth2/authorize'
  token_url 'https://login.microsoftonline.com/12345/oauth2/token'
  scopes 'openid email name groups'
  allowed_domains 'test.local'
  allowed_groups '12345'
end

grafana_config_writer 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end
