property :host,               String,   default: 'localhost'
property :port,               Integer,  default: 3000
property :admin_user,         String,   default: 'admin'
property :admin_password,     String,   default: 'admin'
property :auth_proxy_header,  String

property :backup_path, String, default: '/etc/grafana/backup/datasources'

default_action :create

include GrafanaCookbook::DataSourceApi
include GrafanaCookbook::OrganizationApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }

  get_all_datasources(grafana_options).each do |org_id, datasources|
    directory "#{new_resource.backup_path}/#{org_id}" do
      recursive true
    end
    datasources.each do |ds|
      file "#{new_resource.backup_path}/#{org_id}/#{ds['name']}.json" do
        content JSON.pretty_generate(ds)
        action :create
      end
    end
  end
end
