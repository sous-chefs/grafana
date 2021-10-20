[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_generic_oauth

Configures the auth.generic_oauth section of the configuration <https://grafana.com/docs/grafana/latest/auth/generic-oauth/>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                                | Type        | Default | Description                                                   | Allowed Values |
| ----------------------------------- | ----------- | ------- | ------------------------------------------------------------- | -------------- |
| `:enabled`                          | True, False | `false` | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> | true, false    |
| `:allow_sign_up`                    | True, False |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> | true, false    |
| `:client_id`                        | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:client_secret`                    | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:scopes`                           | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:email_attribute_name`             | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:auth_url`                         | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:token_url`                        | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:api_url`                          | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:team_ids`                         | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:allowed_organizations`            | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:role_attribute_path`              | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:tls_skip_verify_insecure`         | True, False |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> | true, false    |
| `:tls_client_cert`                  | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:tls_client_key`                   | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:tls_client_ca`                    | String      |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> |                |
| `:send_client_credentials_via_post` | True, False |         | <https://grafana.com/docs/grafana/latest/auth/generic-oauth/> | true, false    |
