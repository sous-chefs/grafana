[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_security

Configures the core security section of the configuration <http://docs.grafana.org/installation/configuration/#security>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                                    | Type        |  Default                    | Description                                             | Allowed Values
| --------------------------------------- | ----------- | --------------------------- | ------------------------------------------------------- | --------------- |
| `admin_user`                            | String      | `admin`                     | default admin user, created on startup                  |
| `admin_password`                        | String      | `admin`                     | default admin password                                  |
| `secret_key`                            | String      | `SW2YcwTIb9zpOOhoPsMm`      | used for signing.                                       |
| `login_remember_days`                   | Integer     | `7`                         | The number of days the keep me logged in / remember me cookie lasts.|
| `disable_gravatar`                      | true, false | `false`                     | disable gravatar profile images.                        | true, false
| `data_source_proxy_whitelist`           | String      |                             | data source proxy whitelist                      |ip_or_domain:port separated by spaces
| `disable_brute_force_login_protection`  | true, false | `false`                     | disable protection against brute force login attempts.  | true, false
| `allow_embedding`                       | true, false | `false`                     | Allows grafana to be embedded in an iframe              | true, false
| `conf_directory`                        | String      | `/etc/grafana`              | The directory where the Grafana configuration resides   | Valid directory
| `config_file`                           | String      | `/etc/grafana/grafana.ini`  | The Grafana configuration file                          | Valid file path
| `cookbook`                              | String      | `grafana`                   | Which cookbook to look in for the template              |
| `source`                                | String      | `grafana.ini.erb`           | Name of the template                                    |

## Examples

```ruby
grafana_config_security 'grafana'
```

```ruby
grafana_config_security 'grafana' do
  admin_user 'someOtherUsername'
  admin_password 'MySuperSecretPassword'
  disable_gravatar true
  secret_key 'myNewLongStringaaaaaaaaaaaaaaa'
end
```
