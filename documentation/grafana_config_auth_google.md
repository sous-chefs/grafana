# grafana_config_auth_google

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the auth.google section of the configuration <https://grafana.com/docs/grafana/latest/auth/google/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name               | Type        | Default | Description                                            | Allowed Values |
| ------------------ | ----------- | ------- | ------------------------------------------------------ | -------------- |
| `:enabled`         | True, False | `false` | <https://grafana.com/docs/grafana/latest/auth/google/> | true, false    |
| `:allow_sign_up`   | True, False |         | <https://grafana.com/docs/grafana/latest/auth/google/> | true, false    |
| `:client_id`       | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:client_secret`   | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:scopes`          | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:auth_url`        | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:token_url`       | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:api_url`         | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:allowed_domains` | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
| `:hosted_domain`   | String      |         | <https://grafana.com/docs/grafana/latest/auth/google/> |                |
