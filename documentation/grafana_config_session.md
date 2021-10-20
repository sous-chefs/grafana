[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_session

Configures the core session section of the configuration <http://docs.grafana.org/installation/configuration/#session>. Note, if you're using Grafana v6.2 or newer, cookie/session settings are in Remote Cache and Security. See <https://grafana.com/docs/installation/configuration/#remote-cache> and <https://grafana.com/docs/installation/configuration/#security>.

Introduced: v4.0.0
Removed: v6.2.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                | Type        |  Default                                  | Description                                             | Allowed Values
| ------------------- | ----------- | ------------ | ------------------------------------------------------- | --------------- |
| `session_provider`  | Symbol      | `file`       | Provider to use                                         |memory file redis mysql postgres memcache
| `provider_config`   | String      | `sessions`   | See <http://docs.grafana.org/installation/configuration/#session> |
| `cookie_name`       | String      | `nil`        | Session cookie name,  default changed at Grafana 6.0.0 so programatically determining default in install action |
| `cookie_secure`     | true, false | `false`      | Set to true if you host Grafana behind HTTPS only. Defaults to false. | true, false
| `session_life_time` | Integer     | `86400`      | How long sessions lasts in seconds. Defaults to 86400 (24 hours).|
| `gc_interval_time`  | Integer     | `86400`      | How often to garbase collect                            |
| `conn_max_lifetime` | Integer     | `14400`      | Connection Max Lifetime (seconds, 14400 = 4 hours)      |

## Examples

```ruby
grafana_config_session 'grafana'
```

```ruby
grafana_config_session 'grafana' do
  cookie_secure true
  session_provider :redis
end
```
