property  :instance_name,       String,                   name_property: true
property  :is_sensitive,        [TrueClass, FalseClass],  default: true
property  :conf_directory,      String,                   default: '/etc/grafana'
property  :config_file,         String,                   default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :config_file_ldap,    String,                   default: lazy { ::File.join(conf_directory, 'ldap.toml') }
property  :cookbook,            String,                   default: 'grafana'
property  :source,              String,                   default: 'grafana.ini.erb'
property  :ldap_source,         String,                   default: 'ldap.toml.erb'
property  :service_name,        String,                   default: 'grafana-server'

action :install do
  service new_resource.service_name do
    action [:enable]
    subscribes :restart, ['template[/etc/grafana/grafana.ini]', 'template[/etc/grafana/ldap.toml]'], :immediately
  end

  template ::File.join(new_resource.config_file) do
    source new_resource.source
    cookbook new_resource.cookbook
    variables(
      grafana: node.run_state['sous-chefs'][new_resource.instance_name]['config']
    )
    not_if { node.run_state['sous-chefs'][new_resource.instance_name]['config'].nil? }
    sensitive new_resource.sensitive
  end

  template ::File.join(new_resource.config_file_ldap) do
    source new_resource.ldap_source
    cookbook new_resource.cookbook
    variables(
      ldap: node.run_state['sous-chefs'][new_resource.instance_name]['ldap']
    )
    not_if { node.run_state['sous-chefs'][new_resource.instance_name]['ldap'].nil? }
    sensitive new_resource.sensitive
  end
end
