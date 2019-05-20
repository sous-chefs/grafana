[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_dashboards

Configures the core dashboard section of the configuration <http://docs.grafana.org/installation/configuration/#dashboards>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `versions_to_keep`        |  Integer      | `5`                         | Number dashboard versions to keep (per dashboard).                        |
| `conf_directory`          |  String       | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             |  String       | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_dashboards 'grafana'
```

```ruby
grafana_config_dashboards 'grafana' do
  versions_to_keep 3
end
```
