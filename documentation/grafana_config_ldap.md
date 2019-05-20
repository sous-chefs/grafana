[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_ldap

Configures ldap <http://docs.grafana.org/auth/ldap/>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                            | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `log_filters`                   | String        |                             | Enables additional logging                                                |
| `servers_attributes_name`       | String        | `givenName`                 | Specify names of the ldap attributes your ldap uses                       |
| `servers_attributes_surname`    | String        | `sn`                        | Specify names of the ldap attributes your ldap uses                       |
| `servers_attributes_username`   | String        | `cn`                        | Specify names of the ldap attributes your ldap uses                       |
| `servers_attributes_member_of`  | String        | `memberOf`                  | Specify names of the ldap attributes your ldap uses                       |
| `servers_attributes_email`      | String        | `email`                     | Specify names of the ldap attributes your ldap uses                       |
| `conf_directory`                | String        | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`                   | String        | `/etc/grafana/ldap.toml`    | The Grafana configuration file                                            | Valid file path
| `cookbook`                      | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                        | String        | `ldap.toml.erb`             | Name of the template                                                      |

## Examples

```ruby
grafana_config_ldap 'grafana'
```

```ruby
grafana_config_ldap 'grafana' do
  log_filters 'ldap:debug'
  servers_attributes_username 'username'
end
```
