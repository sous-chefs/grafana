[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_plugins

Configures the core plugins section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#plugins-1>

Introduced: v9.6.0

## Actions

`:install`

## Properties

| Name                      | Type          |  Default                    | Description                                                               |
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- |
| `allow_loading_unsigned_plugins` | String | `''` | <https://grafana.com/docs/grafana/latest/administration/configuration/#allow_loading_unsigned_plugins> |

## Examples

```ruby
grafana_config_plugins 'grafana' do
  allow_loading_unsigned_plugins 'plugin_name'
end
```
