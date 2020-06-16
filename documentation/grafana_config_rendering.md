[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_rendering

Configures a remote HTTP image rendering service, e.g. using https://github.com/grafana/grafana-image-renderer. <https://grafana.com/docs/grafana/latest/installation/configuration/#rendering>

Introduced: v8.8.0

## Actions

`:create`

## Properties

| Name                      | Type     |  Default                       | Description                                                               |
| ------------------------- | -------- | ------------------------------ | ------------------------------------------------------------------------- |
| `server_url`              | String   | `http://localhost:8081/render` | URL to a remote HTTP image renderer service                               |
| `callback_url`            | String   | `http://localhost:3000/`       | If the remote HTTP image renderer service runs on a different server than the Grafana server you may have to configure this to a URL where Grafana is reachable, e.g. http://grafana.domain/. |

## Examples

```ruby
grafana_config_rendering 'grafana'
```

```ruby
grafana_config_rendering 'grafana' do
  callback_url 'http://grafana.domain/'
end
```
