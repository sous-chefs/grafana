grafana_install 'grafana'

grafana_config 'Grafana'

grafana_config_log 'Grafana'

grafana_config_auth_azuread 'Grafana' do
  azuread_name 'Test Azure AD'
  azuread_enabled true
  azuread_allow_sign_up true
  azuread_client_id 'test_id'
  azuread_client_secret 'test_secret'
  azuread_auth_url 'https://login.microsoftonline.com/12345/oauth2/authorize'
  azuread_token_url 'https://login.microsoftonline.com/12345/oauth2/token'
  azuread_scopes 'openid email name groups'
  azuread_allowed_domains 'test.local'
  azuread_allowed_groups '12345'
end

grafana_config_writer 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end
