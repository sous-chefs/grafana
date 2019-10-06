# Upgrading

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
