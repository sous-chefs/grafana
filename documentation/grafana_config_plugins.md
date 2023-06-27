# grafana_config_plugins

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core plugins section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#plugins-1>

Introduced: v9.6.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                                   | Type          | Default | Description |
| -------------------------------------- | ------------- | ------- | ----------- |
| `enable_alpha`                         | True, False   |         |             |
| `allow_loading_unsigned_plugins`       | Array, String |         |             |
| `plugin_admin_enabled`                 | True, False   |         |             |
| `plugin_admin_external_manage_enabled` | True, False   |         |             |
| `plugin_catalog_url`                   | String        |         |             |

## Examples

```ruby
grafana_config_plugins 'grafana' do
  allow_loading_unsigned_plugins %w(plugin_name)
end
```
