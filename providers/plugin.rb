action :install do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  raise "#{plugin_name} is not available" unless ::GrafanaCookbook::Plugin.available?(plugin_name, binary)
  execute "Installing plugin #{plugin_name}" do
    command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'install', binary)
    not_if { current_resource.installed }
  end
end

action :update do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  if current_resource.installed
    execute "Updating plugin #{plugin_name}" do
      command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'update', binary)
    end
  else
    Chef::Log.warn "Impossible to upgrade plugin #{plugin_name} because it is not installed. We will install it."
    run_action(:install)
  end
end

action :remove do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  execute "Removing plugin #{name}" do
    command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'remove', binary)
    only_if { current_resource.installed }
  end
end

def load_current_resource
  @current_resource = Chef::Resource::GrafanaPlugin.new(@new_resource.name)
  @current_resource.installed = GrafanaCookbook::Plugin.installed?(new_resource.name, new_resource.grafana_cli_bin)
end
