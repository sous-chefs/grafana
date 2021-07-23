
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

grafana_datasource 'graphite-test' do
  auth_proxy_header auth_header
  datasource(
    type: 'graphite',
    url: 'http://10.0.0.15:8080',
    access: 'direct',
    organization: 'Sous-Chefs'
  )
end

grafana_datasource 'influxdb-test' do
  datasource(
    type: 'influxdb',
    url: 'http://10.0.0.10:8086',
    access: 'proxy',
    database: 'metrics',
    user: 'dashboard',
    password: 'dashpass',
    isdefault: true,
    organization: 'Sous-Chefs'
  )
  action :create
end

directory "#{Chef::Config['file_cache_path']}/grafana/dashboards" do
  recursive true
  owner 'root'
  group 'grafana'
end

cookbook_file "#{Chef::Config['file_cache_path']}/grafana/dashboards/sample-dashboard.json" do
  source 'sample-dashboard.json'
  owner 'root'
  group 'grafana'
  mode '0755'
  action :create
end

cookbook_file "#{Chef::Config['file_cache_path']}/grafana/dashboards/sample-dashboard-folder.json" do
  source 'sample-dashboard-folder.json'
  owner 'root'
  group 'grafana'
  mode '0755'
  action :create
end

grafana_dashboard 'sample-dashboard' do
  auth_proxy_header auth_header
  dashboard(
    path: "#{Chef::Config['file_cache_path']}/grafana/dashboards/sample-dashboard.json",
    overwrite: true,
    organization: 'Sous-Chefs'
  )
  action [:create, :update]
end

grafana_folder 'StayOrganized' do
  folder(
    overwrite: true,
    title: 'StayOrganized',
    permissions: {
      items: [
        {
          "role": 'Viewer',
          "permission": 1,
        },
        {
          "role": 'Editor',
          "permission": 2,
        },
      ],
    },
    organization: 'Sous-Chefs'
  )
  action :create
end

grafana_folder 'StayOrganized' do
  folder(
    title: 'StayOrganized2',
    organization: 'Sous-Chefs'
  )
  action :update
end

grafana_dashboard 'sample-dashboard-folder' do
  auth_proxy_header auth_header
  dashboard(
    path: "#{Chef::Config['file_cache_path']}/grafana/dashboards/sample-dashboard-folder.json",
    overwrite: true,
    organization: 'Sous-Chefs',
    folder: 'StayOrganized2'
  )
  action [:create, :update]
end

grafana_dashboard_template 'sample-dashboard-template' do
  auth_proxy_header auth_header

  organization 'Sous-Chefs'
  folder 'StayOrganized2'

  template_source 'sample-dashboard-template.json.erb'
  template_cookbook 'test'

  template_vars(
    random_walk: 'injected value'
  )

  action [:create, :update]
end

grafana_dashboards_backup 'Backup Dashboards to File' do
  auth_proxy_header auth_header
end

grafana_datasources_backup 'Backup Datasources to File' do
  auth_proxy_header auth_header
end
