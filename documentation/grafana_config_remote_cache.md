[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_remote_cache

Configures the remote cache section of the configuration <http://docs.grafana.org/installation/configuration/#remote-cache>.

Introduced: v6.2.0

## Actions

- `:create`
- `:delete`

## Properties

| Name      | Type   | Default    | Description                                                        | Allowed Values           |
| --------- | ------ | ---------- | ------------------------------------------------------------------ | ------------------------ |
| `type`    | Symbol | `database` | Provider to use                                                    | redis memcached database |
| `connstr` | String |            | See <https://grafana.com/docs/installation/configuration/#connstr> |

## Examples

```ruby
grafana_config_remote_cache 'grafana'
```

```ruby
grafana_config_remote_cache 'grafana' do
  type :memcached
  connstr '127.0.0.1:11211'
end
```
