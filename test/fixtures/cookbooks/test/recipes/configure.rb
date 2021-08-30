auth_header = 'X-WEBAUTH-USER'

grafana_install 'grafana' do
  version '7.5.0' # last version to have old dashboard api
end

grafana_config 'Grafana'

grafana_config_auth 'Grafana' do
  disable_login_form false
  proxy_enabled true
  proxy_header_name auth_header
  proxy_header_property 'username'
  proxy_whitelist '127.0.0.1, ::1'
  login_cookie_name 'grafana_session'
end

grafana_config_dashboards 'Grafana' do
  versions_to_keep 2
  min_refresh_interval '3s'
end

grafana_config_writer 'Grafana'

include_recipe 'test::sleep'

# Needed for some inspec tests
package 'curl'

grafana_organization 'Sous-Chefs' do
  auth_proxy_header auth_header
  action :create
end

# Create Only
grafana_user 'foo.bar' do
  auth_proxy_header auth_header
  user(
    name: 'Foo Bar',
    email: 'foo@example.com',
    password: 'foobar123',
    isAdmin: false,
    organizations: [
      { name: 'Sous-Chefs', role: 'Viewer' },
    ]
  )
  action :create
end

# Create Update
grafana_user 'j.smith' do
  auth_proxy_header auth_header
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test123',
    isAdmin: true,
    organizations: [
      { name: 'Sous-Chefs', role: 'Admin' },
    ]
  )
  action [:create, :update]
end

# Create, update delete
grafana_user 'sous.chef' do
  auth_proxy_header auth_header
  user(
    name: 'Sous Chefs',
    email: 'help@sous-chefs.org',
    password: 'Cooking123',
    isAdmin: false,
    organizations: [
      { name: 'Sous-Chefs', role: 'Viewer' },
    ]
  )
  action [:create, :update, :delete]
end
