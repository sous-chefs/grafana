[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_ldap_group_mappings

Configures ldap group mappings <http://docs.grafana.org/auth/ldap/#group-mappings>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name              | Type          |  Default                 | Description                                                               | Allowed Values
| ----------------- | ------------- | ------------------------ | ------------------------------------------------------------------------- | --------------- |
| `group_dn`        | String        |                          | LDAP distinguished name (DN) of LDAP group. If you want to match all (or no LDAP groups) then you can use wildcard ("*") |
| `org_role`        | String        | `Viewer`                 | Assign users of group_dn the organization role | Admin Editor Viewer
| `grafana_admin`   | true, false   | `false`                  | When true makes user of group_dn Grafana server admin. A Grafana server admin has admin access over all organizations and users. Available in Grafana v5.3 and above|
| `org_id`          | Integer       | `1`                      | The Grafana organization database id. Setting this allows for multiple group_dn’s to be assigned to the same org_role provided the org_id differs |
| `conf_directory`  | String        | `/etc/grafana`           | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`     | String        | `/etc/grafana/ldap.toml` | The Grafana configuration file                                            | Valid file path
| `cookbook`        | String        | `grafana`                | Which cookbook to look in for the template                                |
| `source`          | String        | `ldap.toml.erb`          | Name of the template                                                      |

## Examples

```ruby
grafana_config_ldap_group_mappings 'cn=admins,dc=grafana,dc=org' do
  org_role      'Admin'
  grafana_admin true
  org_id        1
end
```

```ruby
grafana_config_ldap_group_mappings 'cn=readers,dc=grafana,dc=org' do
  org_role      'Viewer'
end
```
