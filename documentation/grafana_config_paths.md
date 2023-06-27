# grafana_config_paths

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core paths section of the configuration <http://docs.grafana.org/installation/configuration/#paths>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                 | Type   | Default                    | Description                                                                       | Allowed Values  |
| -------------------- | ------ | -------------------------- | --------------------------------------------------------------------------------- | --------------- |
| `data`               | String | `/var/lib/grafana`         | Path to where Grafana stores it's data                                            | Valid Directory |
| `temp_data_lifetime` | String | `24h`                      | How long temporary images in data directory should be kept                        |                 |
| `logs`               | String | `/var/log/grafana`         | Path to where Grafana will store logs                                             |                 |
| `plugins`            | String | `/var/lib/grafana/plugins` | Directory where grafana will automatically scan and look for plugins              |                 |
| `provisioning`       | String | `conf/provisioning`        | Folder that contains provisioning config files that grafana will apply on startup |                 |

## Examples

```ruby
grafana_config_paths 'grafana'
```

```ruby
grafana_config_paths 'grafana' do
  data '/data/grafana'
  logs '/data/grafana/logs'
end
```
