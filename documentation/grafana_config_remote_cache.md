[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_remote_cache

Configures the remote cache section of the configuration <http://docs.grafana.org/installation/configuration/#remote-cache>.

Introduced: v6.2.0

## Actions

`:create`

## Properties

| Name                | Type        |  Default                                  | Description                                             | Allowed Values
| ------------------- | ----------- | ----------------------------------------- | ------------------------------------------------------- | --------------- |
| `remote_cache_type` | String      | `database`                                | Provider to use                                         |redis memcached database
| `remote_cache_config`   | String      |                                       | See <https://grafana.com/docs/installation/configuration/#connstr> |
| `conf_directory`    | String      | `/etc/grafana`                            | The directory where the Grafana configuration resides   | Valid directory
| `config_file`       | String      | `/etc/grafana/grafana.ini`                | The Grafana configuration file                          | Valid file path
| `cookbook`          | String      | `grafana`                                 | Which cookbook to look in for the template              |
| `source`            | String      | `grafana.ini.erb`                         | Name of the template                                    |

## Examples

```ruby
grafana_config_remote_cache 'grafana'
```

```ruby
grafana_config_remote_cache 'grafana' do
  type 'memcached'
  connstr '127.0.0.1:11211'
end
```
