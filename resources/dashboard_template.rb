property :host,               String,   default: 'localhost'
property :port,               Integer,  default: 3000
property :url_path_prefix,    String
property :admin_user,         String,   default: 'admin'
property :admin_password,     String,   default: 'admin'
property :auth_proxy_header,  String

property :template_path,      String,  default: '/etc/grafana/dashboards'
property :template_source,    String,  required: true
property :template_vars,      Hash,    default: {}
property :template_cookbook,  String
property :organization,       String
property :folder,             String

default_action :create

action :create do
  templated_dashboard(:create)
end

action :update do
  templated_dashboard(:update)
end

action :delete do
  file dashboard_path do
    action :delete
  end

  grafana_dashboard new_resource.name do
    host new_resource.host
    port new_resource.port
    url_path_prefix new_resource.url_path_prefix
    auth_proxy_header new_resource.auth_proxy_header
    admin_user new_resource.admin_user
    admin_password new_resource.admin_password
    action :delete
  end
end

action_class do
  def dashboard_path
    template_filename = ::File.basename(new_resource.template_source, '.erb')
    "#{new_resource.template_path}/#{template_filename}"
  end

  def templated_dashboard(dashboard_action)
    directory ::File.dirname(dashboard_path) do
      recursive true
    end

    template dashboard_path do
      source new_resource.template_source
      cookbook new_resource.template_cookbook
      backup false
      variables new_resource.template_vars
    end

    dashboard_hash = {
      name: new_resource.name,
      path: dashboard_path,
      folder: new_resource.folder,
      overwrite: true,
      organization: new_resource.organization,
    }

    grafana_dashboard new_resource.name do
      host new_resource.host
      port new_resource.port
      url_path_prefix new_resource.url_path_prefix
      auth_proxy_header new_resource.auth_proxy_header
      admin_user new_resource.admin_user
      admin_password new_resource.admin_password
      dashboard dashboard_hash
      action dashboard_action
    end
  end
end
