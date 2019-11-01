[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_snapshots

Configures the core snapshots section of the configuration <http://docs.grafana.org/installation/configuration/#snapshots>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type        |  Default                                  | Description                                               | Allowed Values
| ------------------------- | ----------- | ----------------------------------------- | --------------------------------------------------------- | --------------- |
| `external_enabled`        | true, false | `true`                                    | Set to false to disable external snapshot publish endpoint| true, false
| `external_snapshot_url`   | String      | `https://snapshots-origin.raintank.io`    | Set root url to a Grafana instance where you want to publish external snapshots |
| `external_snapshot_name`  | String      | `Publish to snapshot.raintank.io`         | Set name for external snapshot button                     |
| `snapshot_remove_expired` | true, false | `true`                                    | Enabled to automatically remove expired snapshots         |

## Examples

```ruby
grafana_config_snapshots 'grafana'
```

```ruby
grafana_config_snapshots 'grafana' do
  external_enabled false
end
```
