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
