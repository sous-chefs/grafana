[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_plugins

Configures the core plugins section of the configuration <http://docs.grafana.org/installation/configuration/#plugins>

Introduced: v9.5.2

## Actions

`:install`

## Properties

| Name                      | Type          |  Default                    | Description                                                               |
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- |
| `allow_loading_unsigned_plugins` | String | `''` | Enter a comma-separated list of plugin identifiers to identify<br />plugins that are allowed to be loaded even if they lack a valid signature. |

## Examples

```ruby
grafana_config_plugins 'grafana' do
  allow_loading_unsigned_plugins 'plugin_name'
end
```
