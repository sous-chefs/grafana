[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_rendering

Configures a remote HTTP image rendering service, e.g. using https://github.com/grafana/grafana-image-renderer. <https://grafana.com/docs/grafana/latest/installation/configuration/#rendering>

Introduced: v8.8.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                              | Type    | Default                        | Description                                                                                                                                                                                                                                                          |
| --------------------------------- | ------- | ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `server_url`                      | String  | `http://localhost:8081/render` | URL to a remote HTTP image renderer service                                                                                                                                                                                                                          |
| `callback_url`                    | String  | `http://localhost:3000/`       | If the remote HTTP image renderer service runs on a different server than the Grafana server you may have to configure this to a URL where Grafana is reachable, e.g. http://grafana.domain/.                                                                        |
| `concurrent_render_request_limit` | Integer | `http://localhost:3000/`       | Concurrent render request limit affects when the /render HTTP endpoint is used. Rendering many images at the same time can overload the server, which this setting can help protect against by only allowing a certain number of concurrent requests. Default is 30. |

## Examples

```ruby
grafana_config_rendering 'grafana'
```

```ruby
grafana_config_rendering 'grafana' do
  callback_url 'http://grafana.domain/'
end
```
