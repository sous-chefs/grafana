[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_otka

Configures the auth.otka section of the configuration <https://grafana.com/docs/grafana/latest/auth/okta/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                   | Type        | Default | Description                                          | Allowed Values |
| ---------------------- | ----------- | ------- | ---------------------------------------------------- | -------------- |
| `:name`                | String      | `Okta`  | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:enabled`             | True, False | `false` | <https://grafana.com/docs/grafana/latest/auth/okta/> | true, false    |
| `:allow_sign_up`       | True, False |         | <https://grafana.com/docs/grafana/latest/auth/okta/> | true, false    |
| `:client_id`           | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:client_secret`       | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:scopes`              | Array       |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:auth_url`            | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:token_url`           | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:api_url`             | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:allowed_domains`     | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:allowed_groups`      | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:hosted_domain`       | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
| `:role_attribute_path` | String      |         | <https://grafana.com/docs/grafana/latest/auth/okta/> |                |
