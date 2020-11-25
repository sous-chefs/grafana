property :host,               String,   default: 'localhost'
property :port,               Integer,  default: 3000
property :url_path_prefix,    String
property :admin_user,         String,   default: 'admin'
property :admin_password,     String,   default: 'admin'
property :auth_proxy_header,  String

property :backup_path, String, default: '/etc/grafana/backup/datasources'
property :clean_folder, [true, false], default: true
property :sensitive, [true, false], default: true

default_action :create

include GrafanaCookbook::DataSourceApi
include GrafanaCookbook::OrganizationApi

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    url_path_prefix: new_resource.url_path_prefix,
    user: new_resource.admin_user,
    password: new_resource.admin_password,
    auth_proxy_header: new_resource.auth_proxy_header,
  }

  directory "#{new_resource.backup_path}" do
    recursive true
    only_if { new_resource.clean_folder }
    action :delete
  end

  get_all_datasources(grafana_options).each do |org_id, datasources|
    directory "#{new_resource.backup_path}/#{org_id}" do
      recursive true
    end
    datasources.each do |ds|
      file "#{new_resource.backup_path}/#{org_id}/#{ds['name']}.json" do
        content JSON.pretty_generate(ds)
        sensitive new_resource.sensitive
        action :create
      end
    end
  end
end
