[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_session

Configures the core session section of the configuration <http://docs.grafana.org/installation/configuration/#session>. Note, if you're using Grafana v6.2 or newer, cookie/session settings are in Remote Cache and Security. See <https://grafana.com/docs/installation/configuration/#remote-cache> and <https://grafana.com/docs/installation/configuration/#security>.

Introduced: v4.0.0
Removed: v6.2.0

## Actions

`:create`

## Properties

| Name                | Type        |  Default                                  | Description                                             | Allowed Values
| ------------------- | ----------- | ----------------------------------------- | ------------------------------------------------------- | --------------- |
| `session_provider`  | String      | `file`                                    | Provider to use                                         |memory file redis mysql postgres memcache
| `provider_config`   | String      | `sessions`                                | See <http://docs.grafana.org/installation/configuration/#session> |
| `cookie_name`       | String      | `grafana_sess`                            | Session cookie name                           |
| `cookie_secure`     | true, false | `false`                                   | Set to true if you host Grafana behind HTTPS only. Defaults to false. | true, false
| `session_life_time` | Integer     | `86400`                                   | How long sessions lasts in seconds. Defaults to 86400 (24 hours).|
| `gc_interval_time`  | Integer     | `86400`                                   | How often to garbase collect                            |
| `conn_max_lifetime` | Integer     | `14400`                                   | Connection Max Lifetime (seconds, 14400 = 4 hours)      |
| `conf_directory`    | String      | `/etc/grafana`                            | The directory where the Grafana configuration resides   | Valid directory
| `config_file`       | String      | `/etc/grafana/grafana.ini`                | The Grafana configuration file                          | Valid file path
| `cookbook`          | String      | `grafana`                                 | Which cookbook to look in for the template              |
| `source`            | String      | `grafana.ini.erb`                         | Name of the template                                    |

## Examples

```ruby
grafana_config_session 'grafana'
```

```ruby
grafana_config_session 'grafana' do
  cookie_secure true
  session_provider 'redis'
end
```
