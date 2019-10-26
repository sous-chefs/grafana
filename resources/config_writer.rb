property  :instance_name,       String, name_property: true
property  :conf_directory,      String, default: '/etc/grafana'
property  :config_file,         String, default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :cookbook,            String, default: 'grafana'
property  :source,              String, default: 'grafana.ini.erb'

action :install do
  template ::File.join(new_resource.config_file) do
    source new_resource.source
    cookbook new_resource.cookbook
    variables(
      grafana: node.run_state['sous-chefs'][new_resource.instance_name]
    )
  end
end
