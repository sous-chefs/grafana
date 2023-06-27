# grafana_config_auth_gitlab

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the auth.gitlab section of the configuration <https://grafana.com/docs/grafana/latest/auth/gitlab/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                     | Type        | Default | Description                                            | Allowed Values |
| ------------------------ | ----------- | ------- | ------------------------------------------------------ | -------------- |
| `:enabled`               | True, False | `false` | <https://grafana.com/docs/grafana/latest/auth/gitlab/> | true, false    |
| `:allow_sign_up`         | True, False |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> | true, false    |
| `:client_id`             | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
| `:client_secret`         | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
| `:scopes`                | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
| `:auth_url`              | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
| `:token_url`             | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
| `:api_url`               | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
| `:allowed_organizations` | String      |         | <https://grafana.com/docs/grafana/latest/auth/gitlab/> |                |
