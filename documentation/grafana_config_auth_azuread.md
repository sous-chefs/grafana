[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_azuread

Configures the auth.azuread section of the configuration <https://grafana.com/docs/grafana/latest/auth/azuread/>

Introduced: v6.7.0

## Actions

`:create`

## Properties

| Name                                              | Type          |  Default                    | Description                                                         | Allowed Values
| ------------------------------------------------  | ------------- | --------------------------- | ------------------------------------------------------------------  | --------------- |
| `:azuread_name`                                   | String        | `AzureAD`                   | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_enabled`                                | True, False   | `false`                     | Enable AzureAD Auth                                                 | true, false
| `:azuread_allow_sign_up`                          | True, False   | `true`                      | <https://grafana.com/docs/grafana/latest/auth/azuread/>             | true, false
| `:azuread_client_id`                              | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_client_secret`                          | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_scopes`                                 | String        | `openid email profile`      | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_auth_url`                               | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_token_url`                              | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_allowed_domains`                        | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
| `:azuread_allowed_roles`                          | String        |                             | <https://grafana.com/docs/grafana/latest/auth/azuread/>             |
