# grafana_config_ldap_server

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures ldap servers <https://grafana.com/docs/grafana/latest/auth/ldap/#ldap-authentication>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                                 | Type        | Default                      | Description                                                                                                            | Allowed Values      |
| ------------------------------------ | ----------- | ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------- |
| `host`                               | String      |                              | Name Property, Ldap server host                                                                                        |                     |
| `port`                               | Integer     | `389`                        | Port to connect to host on                                                                                             | Admin Editor Viewer |
| `use_ssl`                            | true, false | `false`                      | Set to true if ldap server supports TLS                                                                                | true, false         |
| `start_tls`                          | true, false | `false`                      | Set to true if connect ldap server with STARTTLS pattern                                                               | true, false         |
| `ssl_skip_verify`                    | true, false | `false`                      | set to true if you want to skip ssl cert validation                                                                    | true, false         |
| `root_ca_cert`                       | String      |                              | set to the path to your root CA certificate                                                                            |                     |
| `client_cert`                        | String      |                              | Authentication against LDAP servers requiring client certificates                                                      |                     |
| `client_key`                         | String      |                              | Authentication against LDAP servers requiring client certificates                                                      |                     |
| `bind_dn`                            | String      | `cn=admin,dc=grafana,dc=org` | Search user bind dn                                                                                                    |                     |
| `bind_password`                      | String      | `grafana`                    | Search user bind password, If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;""" |                     |
| `search_filter`                      | String      | `(cn=%s)`                    | User search filter                                                                                                     |                     |
| `search_base_dns`                    | Array       |                              | An array of base dns to search through                                                                                 |                     |
| `group_search_filter`                | String      |                              | POSIX, Group search filter, to retrieve the groups of which the user is a member                                       |                     |
| `group_search_base_dns`              | Array       |                              | POSIX, An array of the base DNs to search through for groups. Typically uses ou=groups                                 |                     |
| `group_search_filter_user_attribute` | String      |                              | POSIX, the %s in the search filter will be replaced with the attribute defined below                                   |                     |

## Examples

```ruby
grafana_config_ldap_servers '127.0.0.1' do
  port            389
  use_ssl         false
  start_tls       false
  ssl_skip_verify false
  bind_dn         'cn=admin,dc=grafana,dc=org'
  bind_password   'SuperSecretPassword'
  search_filter   '(cn=%s)'
  search_base_dns %w( dc=grafana,dc=org )
end
```
