# Upgrading

## 8.0.0

ensure your `instance_name` (Name property) lines up across all `grafana_config_*` and `grafana_config` resources
Remove any resources of type `service` of `grafana-server`
Remove any `source`, `cookbook`, `config_file` and `config_directory` overrides from all `grafana_config_*` resources
Remove any `cookbook` and `config_directory` overrides from the `grafana_config` resource
Add the `grafana_config_writer` to the end of your config resources, this will create the config file on disk and restart grafana to allow any api calls to work straight after
Change `ldap_config_servers` `host` property from the name property to a normal property (required)
Change `ldap_config_group_mappings` `group_dn` property fromthe name property to a normal property (required)
Added `instance_name` to above resources as name property, this should line up across all config resources
Change `grafana_config_database` property `type` to a symbol
Change `grafana_config_database` property `ssl_mode` to a symbol or true/false
Change `grafana_config_remote_cache` property `remote_cache_type` to a symbol
Change `grafana_config_server` property `protocol` to a symbol
Change `grafana_config_session` property `session_provider` to a symbol

## 7.0.0

Create a resource for `service` of `grafana-server` and subscribe to changes to config files

```ruby
service 'grafana-server' do
  action [:enable, :start]
  subscribes :restart, ['template[/etc/grafana/grafana.ini]', 'template[/etc/grafana/ldap.toml]'], :delayed
end
```

## 6.0.0

Resource `grafana_config_ldap_servers` has had the property `group_search_base_dns` changed to an Array

## 5.0.0

Fixes an issue where the `database_name` property on `config_database` was not being taken, this has now been resolved and will default to `grafana` from now on.

## 4.0.0

This cookbook has changed to resource driven configuration and you will need to migrate to these resources
