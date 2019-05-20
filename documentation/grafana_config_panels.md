[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_panels

Configures the core panels section of the configuration <http://docs.grafana.org/installation/configuration/#panels>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `enable_alpha`            | true, false   | `false`                     | Set to true if you want to test panels that are not yet ready for general usage.| true, false
| `conf_directory`          | String        | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String        | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_panels 'grafana'
```

```ruby
grafana_config_panels 'grafana' do
  enable_alpha true
end
```
