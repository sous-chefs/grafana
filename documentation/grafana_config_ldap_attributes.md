[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_ldap_attributes

Configures ldap group mappings <https://grafana.com/docs/grafana/latest/auth/ldap/#grafana-ldap-configuration>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                  | Type   | Default     | Description                                     | Allowed Values |
| --------------------- | ------ | ----------- | ----------------------------------------------- | -------------- |
| `host`                | String |             | The LDAP host to apply the attribute mapping to |                |
| `attribute_name`      | String | `givenName` |                                                 |                |
| `attribute_surname`   | String | `sn`        |                                                 |                |
| `attribute_username`  | String | `cn`        |                                                 |                |
| `attribute_member_of` | String | `memberOf`  |                                                 |                |
| `attribute_email`     | String | `email`     |                                                 |                |
