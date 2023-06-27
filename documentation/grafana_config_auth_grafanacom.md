# grafana_config_auth_grafanacom

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the auth.grafana_com section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                     | Type        | Default      | Description                                                                             | Allowed Values |
| ------------------------ | ----------- | ------------ | --------------------------------------------------------------------------------------- | -------------- |
| `:enabled`               | True, False | `false`      | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com> | true, false    |
| `:allow_sign_up`         | True, False |              | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com> | true, false    |
| `:client_id`             | String      |              | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com> |                |
| `:client_secret`         | String      |              | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com> |                |
| `:scopes`                | String      | `user:email` | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com> |                |
| `:allowed_organizations` | String      |              | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafana_com> |                |
