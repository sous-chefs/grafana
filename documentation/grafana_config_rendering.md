# grafana_config_rendering

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures a remote HTTP image rendering service, e.g. using <https://github.com/grafana/grafana-image-renderer>. <https://grafana.com/docs/grafana/latest/installation/configuration/#rendering>

Introduced: v8.8.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                              | Type    | Default                        | Description                                      |
| --------------------------------- | ------- | ------------------------------ | ------------------------------------------------ |
| `server_url`                      | String  | `http://localhost:8081/render` | URL to a remote HTTP image renderer service      |
| `callback_url`                    | String  | `http://localhost:3000/`       | URL where Grafana is reachable from the renderer |
| `concurrent_render_request_limit` | Integer | `30`                           | Concurrent render request limit (Default: 30)    |

## Examples

```ruby
grafana_config_rendering 'grafana'
```

```ruby
grafana_config_rendering 'grafana' do
  callback_url 'http://grafana.domain/'
end
```
