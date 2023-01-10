[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_dashboards

Configures the core dashboard section of the configuration <http://docs.grafana.org/installation/configuration/#dashboards>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                        | Allowed Values  |
| ------------------------- | ------------- | --------------------------- | -------------------------------------------------- | --------------- |
| `versions_to_keep`        |  Integer      | `5`                         | Number dashboard versions to keep (per dashboard). |                 |
| `min_refresh_interval`    |  Integer      | ``                          | Minimum dashboard refresh interval.                | Xs, Xm, Xh, Xd  |

## Examples

```ruby
grafana_config_dashboards 'grafana'
```

```ruby
grafana_config_dashboards 'grafana' do
  versions_to_keep 3
end
```
