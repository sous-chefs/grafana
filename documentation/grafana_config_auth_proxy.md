[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_proxy

Configures the auth.proxy section of the configuration <https://grafana.com/docs/grafana/latest/auth/auth-proxy/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                  | Type        | Default      | Description                                                | Allowed Values |
| --------------------- | ----------- | ------------ | ---------------------------------------------------------- | -------------- |
| `:enabled`            | True, False | `false`      | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> | true, false    |
| `:header_name`        | String      |              | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> |                |
| `:header_property`    | String      |              | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> |                |
| `:auto_sign_up`       | True, False |              | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> | true, false    |
| `:ldap_sync_ttl`      | Integer     | `user:email` | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> |                |
| `:whitelist`          | String      |              | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> |                |
| `:headers`            | String      | `user:email` | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> |                |
| `:enable_login_token` | True, False | `user:email` | <https://grafana.com/docs/grafana/latest/auth/auth-proxy/> | true, false    |
