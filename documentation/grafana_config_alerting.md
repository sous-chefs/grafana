[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_alerting

Configures the core alerting section of the configuration <http://docs.grafana.org/installation/configuration/#alerting>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                           | Type        | Default | Description                                                                                                            | Allowed Values |
| ------------------------------ | ----------- | ------- | ---------------------------------------------------------------------------------------------------------------------- | -------------- |
| `enabled`                      | True, False | `false` | Set to false to disable alerting engine and hide Alerting from UI.                                                     | true, false    |
| `execute_alerts`               | True, False | `nil`   | Makes it possible to turn off alert rule execution.                                                                    | true, false    |
| `error_or_timeout`             | String      | `nil`   | Default setting for new alert rules                                                                                    |                |
| `nodata_or_nullvalues`         | String      | `nil`   | Default setting for how Grafana handles nodata or null values in alerting                                              |                |
| `concurrent_render_limit`      | Integer     | `nil`   | Maximum number of renders at the same time                                                                             |                |
| `evaluation_timeout_seconds`   | Integer     | `nil`   | Sets the alert calculation timeout. Default value is 30.                                                               |                |
| `notification_timeout_seconds` | Integer     | `nil`   | Sets the alert notification timeout. Default value is 30.                                                              |                |
| `max_attempts`                 | Integer     | `nil`   | Sets a maximum limit on attempts to sending alert notifications. Default value is 3.                                   |                |
| `min_interval_seconds`         | Integer     | `nil`   | Sets the minimum interval between rule evaluations. Default value is 1.                                                |                |
| `max_annotation_age`           | String      | `nil`   | Configures for how long alert annotations are stored. Default is 0, which keeps them forever.                          |                |
| `max_annotations_to_keep`      | String      | `nil`   | Configures max number of alert annotations that Grafana stores. Default value is 0, which keeps all alert annotations. |                |

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
