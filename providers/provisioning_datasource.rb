require 'chef/mash'

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :update do
  new_resource.datasource[:name] = new_resource.name

  template ::File.join(node['grafana']['provisioning_dir'], 'datasources', new_resource.name + '.yml') do
    cookbook 'grafana'
    source 'datasource.yml.erb'
    user node['grafana']['user']
    group node['grafana']['group']
    mode 0600
    variables(
      'datasource_name' => new_resource.datasource[:name],
      'datasource_type' => new_resource.datasource[:type],
      'datasource_url' => new_resource.datasource[:url],
      'access' => new_resource.datasource[:access],
      'organization_id' => new_resource.datasource[:organization_id],
      'json_data' => new_resource.datasource[:json_data].to_json,
      'version' => new_resource.datasource[:version],
      'database' => new_resource.datasource[:database],
      'user' => new_resource.datasource[:user],
      'password' => new_resource.datasource[:password],
      'basic_auth_enabled' => new_resource.datasource[:basic_auth_enabled],
      'basic_auth_user' => new_resource.datasource[:basic_auth_user],
      'basic_auth_password' => new_resource.datasource[:basic_auth_password],
      'with_credentials' => new_resource.datasource[:with_credentials],
      'is_default' => new_resource.datasource[:is_default],
      'secure_json_data' =>  new_resource.datasource[:secure_json_data].to_json,
      'editable' => new_resource.datasource[:editable],
    )
    notifies :restart, 'service[grafana-server]'
  end
end

action :delete do
  template ::File.join(node['grafana']['provisioning_dir'], 'datasources', new_resource.name + '.yml') do
    cookbook 'grafana'
    source 'datasource.yml.erb'
    variables(
      'datasource_name' => new_resource.datasource[:name],
      'organization_id' => new_resource.datasource[:organization_id],
      'is_delete' => true
    )
    notifies :restart, 'service[grafana-server]'
  end
end
