auth_header = 'X-WEBAUTH-USER'

grafana_install 'grafana'

grafana_config 'Grafana'

grafana_config_auth 'Grafana' do
  disable_login_form true
  proxy_enabled true
  proxy_header_name auth_header
  proxy_header_property 'username'
  proxy_whitelist '127.0.0.1, ::1'
  login_cookie_name 'grafana_session'
end

grafana_config_writer 'Grafana'

grafana_user 'j.smith' do
  auth_proxy_header auth_header
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test123',
    isAdmin: true,
    organizations: [
      { name: 'Main Org.', role: 'Admin' },
    ]
  )
  action %i(create update)
end

grafana_service 'grafana' do
  action %i(enable start)
end
