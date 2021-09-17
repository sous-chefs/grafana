[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_dashboards

Configures the core dashboard section of the configuration <http://docs.grafana.org/installation/configuration/#dashboards>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                          | Type    | Default | Description                                                                                                                                  | Allowed Values                                                                                                                    |
| ----------------------------- | ------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `versions_to_keep`            | Integer |         | Number dashboard versions to keep (per dashboard).                                                                                           |                                                                                                                                   |
| `min_refresh_interval`        | String  |         | Minimum dashboard refresh interval. When set, this will restrict users to set the refresh interval of a dashboard lower than given interval. | The interval string is a possibly signed sequence of decimal numbers, followed by a unit suffix (ms, s, m, h, d), e.g. 30s or 1m. |
| `default_home_dashboard_path` | String  |         | Path to the default home dashboard. If this value is empty, then Grafana uses StaticRootPath + “dashboards/home.json”.                       |                                                                                                                                   |

## Examples

```ruby
grafana_config_dashboards 'grafana'
```

```ruby
grafana_config_dashboards 'grafana' do
  versions_to_keep 3
  min_refresh_interval '10s'
end
```
