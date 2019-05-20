[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_metrics

Configures the core metrics section of the configuration <http://docs.grafana.org/installation/configuration/#metrics>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                          | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------------- | ------------------------------------------------------------------------- | --------------- |
| `enabled`                 | true, false   | `true`                            | Enable metrics reporting                                                  | true, false
| `interval_seconds`        | Integer       | `10`                              | If set configures the username to use for basic authentication on the metrics endpoint.|
| `basic_auth_username`     | String        |                                   | If set configures the password to use for basic authentication on the metrics endpoint.|
| `basic_auth_password`     | String        |                                   | Flush/Write interval when sending metrics to external TSDB. Defaults to 10s.|
| `graphite_address`        | String        |                                   | Format Hostname or ip:port                                              |
| `graphite_prefix`         | String        | `prod.grafana.%(instance_name)s.` | Graphite metric prefix                                                    |
| `conf_directory`          | String        | `/etc/grafana`                    | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String        | `/etc/grafana/grafana.ini`        | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                         | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`                 | Name of the template                                                      |

## Examples

```ruby
grafana_config_metrics 'grafana'
```

```ruby
grafana_config_metrics 'grafana' do
  basic_auth_username 'grafana_user'
  basic_auth_password 'MySuperSecretPassword'
  graphite_address '127.0.0.1:8080'
end
```
