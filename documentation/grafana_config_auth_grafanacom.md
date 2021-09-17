[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_grafanacom

Configures the auth.grafana_com section of the configuration <https://grafana.com/docs/grafana/latest/auth/grafanacom/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                     | Type        | Default      | Description                                                | Allowed Values |
| ------------------------ | ----------- | ------------ | ---------------------------------------------------------- | -------------- |
| `:enabled`               | True, False | `false`      | <https://grafana.com/docs/grafana/latest/auth/grafanacom/> | true, false    |
| `:allow_sign_up`         | True, False |              | <https://grafana.com/docs/grafana/latest/auth/grafanacom/> | true, false    |
| `:client_id`             | String      |              | <https://grafana.com/docs/grafana/latest/auth/grafanacom/> |                |
| `:client_secret`         | String      |              | <https://grafana.com/docs/grafana/latest/auth/grafanacom/> |                |
| `:scopes`                | String      | `user:email` | <https://grafana.com/docs/grafana/latest/auth/grafanacom/> |                |
| `:allowed_organizations` | String      |              | <https://grafana.com/docs/grafana/latest/auth/grafanacom/> |                |
