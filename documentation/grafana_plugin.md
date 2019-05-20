[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_plugin

This ressource will help you to manage grafana plugins.

## Actions

- `:install`
- `:update`
- `:remove`

## Properties

| Name                  | Type        |  Default                 | Description                                               | Allowed Values
| --------------------- | ----------- | ------------------------ | --------------------------------------------------------- | --------------- |
| `name`                | String      |                          | Name of the plugin.|
| `action`              | String      | `install`                | Valid actions are `install`, `update`, `remove`.|
| `grafana_cli_bin`     | String      | `/usr/sbin/grafana-cli`  | The path to the grafana-cli binary|

## Examples

```ruby
grafana_plugin grafana-clock-panel do
  action :install
  grafana_cli_bin '/usr/sbin/grafana-cli'
end
```
