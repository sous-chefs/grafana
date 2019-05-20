[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_smtp

Configures the core smtp section of the configuration <http://docs.grafana.org/installation/configuration/#smtp>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                | Type        |  Default                                  | Description                                             | Allowed Values
| ------------------- | ----------- | ----------------------------------------- | ------------------------------------------------------- | --------------- |
| `enabled`           | true, false | `false`                                   | Enable use of smtp/email                                | true, false
| `host`              | String      | `localhost:25`                            | smtp host                                               |
| `user`              | String      |                                           | In case of SMTP auth.                                   |
| `password`          | String      |                                           | In case of SMTP auth.                                   |
| `cert_file`         | String      |                                           | File path to a cert file                                |
| `key_file`          | String      |                                           | File path to a key file                                 |
| `skip_verify`       | true, false | `false`                                   |Address used when sending out emails                     | true, false
| `from_address`      | String      | `"admin@grafana-#{node['hostname']}.#{node['domain'].nil? ? 'local' : node['domain']}"`| Connection Max Lifetime (seconds, 14400 = 4 hours)      |
| `from_name`         | String      | `Grafana`                                 | Name to be used when sending out emails                 |
| `ehlo_identity`     | String      |                                           | Name to be used as client identity for EHLO in SMTP dialog|
| `conf_directory`    | String      | `/etc/grafana`                            | The directory where the Grafana configuration resides   | Valid directory
| `config_file`       | String      | `/etc/grafana/grafana.ini`                | The Grafana configuration file                          | Valid file path
| `cookbook`          | String      | `grafana`                                 | Which cookbook to look in for the template              |
| `source`            | String      | `grafana.ini.erb`                         | Name of the template                                    |

## Examples

```ruby
grafana_config_smtp 'grafana'
```

```ruby
grafana_config_smtp 'grafana' do
  enabled true
  host 'smtp.example.com:25'
  user 'grafana_user'
  password 'MySuperSecretPassword'
  from_address 'monitoring@example.com'
end
```
