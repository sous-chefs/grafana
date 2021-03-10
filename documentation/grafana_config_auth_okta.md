[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_okta

Configures the auth.okta section of the configuration <https://grafana.com/docs/grafana/latest/auth/okta/>

Introduced: v7.0

## Actions

`:create`

## Properties

| Name                                      | Type          |  Default                                             | Description                                                      | Allowed Values
| ------------------------------------------| ------------- | ---------------------------------------------------  | ---------------------------------------------------------------  | --------------- |
| `:instance_name`                          | String        | `Okta`                                               | <https://grafana.com/docs/grafana/latest/auth/okta/>             | 
| `:auth_name`                              | String        | `Okta`                                               | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:enabled`                                | True, False   | `false`                                              | Enable Okta Auth                                                 | true, false
| `:allow_sign_up`                          | True, False   | `true`                                               | <https://grafana.com/docs/grafana/latest/auth/okta/>             | true, false
| `:client_id`                              | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:client_secret`                          | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:scopes`                                 | Array         |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:auth_url`                               | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:token_url`                              | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:api_url`                                | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:allowed_domains`                        | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:allowed_groups`                         | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:hosted_domain`                          | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
| `:role_attribute_path`                    | String        |                                                      | <https://grafana.com/docs/grafana/latest/auth/okta/>             |
