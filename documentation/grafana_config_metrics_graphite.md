[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_metrics_graphite

Configures the metrics.graphite section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#metricsgraphite>

## Actions

- `:create`
- `:delete`

## Properties

| Name               | Type   | Default                           | Description                | Allowed Values |
| ------------------ | ------ | --------------------------------- | -------------------------- | -------------- |
| `graphite_address` | String |                                   | Format Hostname or ip:port |                |
| `graphite_prefix`  | String | `prod.grafana.%(instance_name)s.` | Graphite metric prefix     |                |

## Examples

```ruby
grafana_config_metrics_graphite 'grafana' do
  graphite_address '127.0.0.1:8080'
end
```
