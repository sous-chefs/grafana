[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_azuread

Configures the auth.azuread section of the configuration <https://grafana.com/docs/grafana/latest/auth/azuread/>

Introduced: v6.7.0

## Actions

`:install`

## Properties

| Name                                      | Type          |  Default                    | Description                                                         | Allowed Values
| ------------------------------------------| ------------- | --------------------------- | ------------------------------------------------------------------  | --------------- |
| `:auth_name`                              | String        | `AzureAD`                   | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:enabled`                                | True, False   | `false`                     | Enable AzureAD Auth                                                 | true, false
| `:allow_sign_up`                          | True, False   | `true`                      | <https://grafana.com/docs/grafana/latest/auth/azuread/>             | true, false
| `:client_id`                              | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:client_secret`                          | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:scopes`                                 | String        | `openid email profile`      | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:auth_url`                               | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:token_url`                              | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:allowed_domains`                        | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:allowed_roles`                          | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
