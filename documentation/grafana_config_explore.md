[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_explore

Configures the core explore section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `enabled`                 | true, false   | `false`                     | Enable the Explore section                                                | true, false
| `conf_directory`          | String        | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String        | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_explore 'grafana'
```

```ruby
grafana_config_explore 'grafana' do
  enabled true
end
```
