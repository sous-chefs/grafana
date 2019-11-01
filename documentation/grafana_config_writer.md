[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_writer

Writes the declared configuration to disk for both ldap and the core configuration, will also restart grafana if required

Introduced: v8.0.0

## Actions

`:create`

## Properties

| Name                  | Type        |  Default                    | Description                                               | Allowed Values
| --------------------- | ----------- | --------------------------- | --------------------------------------------------------- | --------------- |
| `instance_name`       | String      |                             | Name Property, name of the instance                       |
| `is_sensitive`        | TrueClass, FalseClass| `true`             | flags sensitive on the resource, exists for debug         | `true`, `false`
| `conf_directory`      | String      | `/etc/grafana`              | The directory where the Grafana configuration resides     | Valid directory
| `config_file`         | String      | `/etc/grafana/grafana.ini`  | The Grafana configuration file                            | Valid file path
| `config_file_ldap`    | String      | `/etc/grafana/ldap.toml`    | The Grafana ldap configuration file                       | Valid file path
| `cookbook`            | String      | `grafana`                   | Which cookbook to look in for the template                |
| `source`              | String      | `grafana.ini.erb`           | Name of the template                                      |
| `source_ldap`         | String      | `ldap.toml.erb`             | Name of the template for ldap                             |
| `service_name`        | String      | `grafana-server`            | Name of the service to restart when config changes        |

## Examples

```ruby
grafana_config_writer 'grafana'
```
