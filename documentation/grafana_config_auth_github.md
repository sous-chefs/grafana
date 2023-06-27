# grafana_config_auth_github

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the auth.github section of the configuration <https://grafana.com/docs/grafana/latest/auth/github/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                                | Type        | Default | Description                                                   | Allowed Values |
| ----------------------------------- | ----------- | ------- | ------------------------------------------------------------- | -------------- |
| `:enabled`                          | True, False | `false` | <https://grafana.com/docs/grafana/latest/auth/github/> | true, false    |
| `:allow_sign_up`                    | True, False |         | <https://grafana.com/docs/grafana/latest/auth/github/> | true, false    |
| `:client_id`                        | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:client_secret`                    | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:scopes`                           | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:auth_url`                         | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:token_url`                        | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:api_url`                          | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:team_ids`                         | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
| `:allowed_organizations`            | String      |         | <https://grafana.com/docs/grafana/latest/auth/github/> |                |
