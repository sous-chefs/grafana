# grafana_config_auth_ldap

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the auth.ldap section of the configuration <https://grafana.com/docs/grafana/latest/auth/ldap/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                | Type        | Default                  | Description                                          | Allowed Values |
| ------------------- | ----------- | ------------------------ | ---------------------------------------------------- | -------------- |
| `:enabled`          | True, False | `false`                  | <https://grafana.com/docs/grafana/latest/auth/ldap/> | true, false    |
| `:allow_sign_up`    | True, False |                          | <https://grafana.com/docs/grafana/latest/auth/ldap/> | true, false    |
| `:ldap_config_file` | String      | `/etc/grafana/ldap.toml` | <https://grafana.com/docs/grafana/latest/auth/ldap/> |                |
