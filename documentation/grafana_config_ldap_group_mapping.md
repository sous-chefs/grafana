# grafana_config_ldap_group_mapping

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures ldap group mapping <http://docs.grafana.org/auth/ldap/#group-mappings>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name            | Type        | Default | Description                                 | Allowed Values        |
| --------------- | ----------- | ------- | ------------------------------------------- | --------------------- |
| `host`          | String      |         | The LDAP host to apply the group mapping to |                       |
| `group_dn`      | String      |         |                                             |                       |
| `org_role`      | String      |         |                                             | `Admin Editor Viewer` |
| `grafana_admin` | True, False |         |                                             | true false            |
| `org_id`        | Integer     |         |                                             |                       |

## Examples

```ruby
grafana_config_ldap_group_mapping 'cn=admins,dc=grafana,dc=org' do
  org_role      'Admin'
  grafana_admin true
  org_id        1
end
```

```ruby
grafana_config_ldap_group_mapping 'cn=readers,dc=grafana,dc=org' do
  org_role      'Viewer'
end
```
