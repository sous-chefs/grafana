[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_alerting

Configures the core alerting section of the configuration <http://docs.grafana.org/installation/configuration/#alerting>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `enabled`                 |  True, False  | `true`                      | Set to false to disable alerting engine and hide Alerting from UI.        | true, false
| `execute_alerts`          |  True, False  | `true`                      | Makes it possible to turn off alert rule execution.                       | true, false
| `error_or_timeout`        |  String       | `alerting`                  | Default setting for new alert rules                                       |
| `nodata_or_nullvalues`    |  String       | `no_data`                   | Default setting for how Grafana handles nodata or null values in alerting |
| `concurrent_render_limit` |  Integer      | `5`                         | Maximum nuqmber of renders at the same time                               |
| `conf_directory`          |  String       | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             |  String       | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_alerting 'grafana'
```

```ruby
grafana_config_alerting 'grafana' do
  error_or_timeout 'alerting'
  concurrent_render_limit 10
end
```
