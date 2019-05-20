[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth

Configures the core authentication section of the configuration <http://docs.grafana.org/installation/configuration/#auth>

This resource also allows configuration of different additional backend providers, please refer to the official grafana documentation for configuration

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                                              | Type          |  Default                    | Description                                                         | Allowed Values
| ------------------------------------------------ | -------------  | --------------------------- | ------------------------------------------------------------------  | --------------- |
| `login_cookie_name`                               | String        | `grafana_session`           | The name of the Grafana session cookie.|
| `disable_login_form`                              | True, False   | `false`                     | Set to true to disable (hide) the login form, useful if you use OAuth | true, false
| `disable_signout_menu`                            | String        | `false`                     | Set to true to disable the signout link in the side menu. useful if you use auth.proxy | true, false
| `:signout_redirect_url`                           | String        |                             | URL to redirect the user to after sign out                          |
| `:oauth_auto_login`                               | True, False   | `false`                     | Set to true to attempt login with OAuth automatically, skipping the login screen| true, false
| `:anonymous_enabled`                              | True, False   | `false`                     | enable anonymous access                                             | true, false
| `:anonymous_org_name`                             | String        | `Main Org.`                 | specify organization name that should be used for unauthenticated users|
| `:anonymous_org_role`                             | String        | `Viewer`                    | specify role for unauthenticated users                              |
| `:github_enabled`                                 | True, False   | `false`                     | Enable github OAuth  See <http://docs.grafana.org/auth/github/>     | true, false
| `:github_allow_sign_up`                           | True, False   | `true`                      | <http://docs.grafana.org/auth/github/>                                | true, false
| `:github_client_id`                               | String        |                             | <http://docs.grafana.org/auth/github/>                                |
| `:github_client_secret`                           | String        |                             | <http://docs.grafana.org/auth/github/>                               |
| `:github_scopes`                                  | String        |                             | <http://docs.grafana.org/auth/github/>                                |
| `:github_auth_url`                                | String        | `https://github.com/login/oauth/authorize` | <http://docs.grafana.org/auth/github/>                 |
| `:github_token_url`                               | String        | `https://github.com/login/oauth/access_token` | <http://docs.grafana.org/auth/github/>              |
| `:github_api_url`                                 | String        | `https://api.github.com/user` | <http://docs.grafana.org/auth/github/>                              |
| `:github_team_ids`                                | String        |                             | <http://docs.grafana.org/auth/github/>                                |
| `:github_allowed_organizations`                   | String        |                             | <http://docs.grafana.org/auth/github/>                                |
| `:gitlab_enabled`                                 | True, False   | `false`                     | Enable gitlab OAuth <http://docs.grafana.org/auth/gitlab/>          | true, false
| `:gitlab_allow_sign_up`                           | True, False   | `true`                      | <http://docs.grafana.org/auth/gitlab/>                                | true, false
| `:gitlab_client_id`                               | String        |                             | <http://docs.grafana.org/auth/gitlab/>                                |
| `:gitlab_client_secret`                           | String        |                             | <http://docs.grafana.org/auth/gitlab/>                                |
| `:gitlab_scopes`                                  | String        |                             | <http://docs.grafana.org/auth/gitlab/>                                |
| `:gitlab_auth_url`                                | String        | `https://gitlab.com/oauth/authorize` | <http://docs.grafana.org/auth/gitlab/>                       |
| `:gitlab_token_url`                               | String        | `https://gitlab.com/oauth/token` | <http://docs.grafana.org/auth/gitlab/>                           |
| `:gitlab_api_url`                                 | String        | `https://gitlab.com/api/v4` | <http://docs.grafana.org/auth/gitlab/>                                |
| `:gitlab_allowed_groups`                          | String        |                             | <http://docs.grafana.org/auth/gitlab/>                                |
| `:google_enabled`                                 | True, False   | `false`                     | Enable Google OAuth <http://docs.grafana.org/auth/google/>          | true, false
| `:google_allow_sign_up`                           | True, False   | `true`                      | <http://docs.grafana.org/auth/google/>                                | true, false
| `:google_client_id`                               | String        |                             | <http://docs.grafana.org/auth/google/>                                |
| `:google_client_secret`                           | String        |                             | <http://docs.grafana.org/auth/google/>                                |
| `:google_scopes`                                  | String        | `https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email` | http://docs.grafana.org/auth/google/|
| `:google_auth_url`                                | String        | `https://accounts.google.com/o/oauth2/auth` | <http://docs.grafana.org/auth/google/>                |
| `:google_token_url`                               | String        | `https://accounts.google.com/o/oauth2/token` | <http://docs.grafana.org/auth/google/>               |
| `:google_api_url`                                 | String        | `https://www.googleapis.com/oauth2/v1/userinfo` | <http://docs.grafana.org/auth/google/>            |
| `:google_allowed_domains`                         | String        |                             | <http://docs.grafana.org/auth/google/>                                |
| `:google_hosted_domain`                           | String        |                             | <http://docs.grafana.org/auth/google/>                                |
| `:grafananet_enabled`                             | True, False   | `false`                     | Grafana.com Authentication                                          | true, false
| `:grafananet_allow_sign_up`                       | True, False   | `true`                      | Grafana.com Authentication                                          | true, false
| `:grafananet_client_id`                           | String        |                             | Grafana.com Authentication                                          |
| `:grafananet_client_secret`                       | String        |                             | Grafana.com Authentication                                          |
| `:grafananet_scopes`                              | String        | `user:email`                | Grafana.com Authentication                                          |
| `:grafananet_allowed_organizations`               | String        |                             | Grafana.com Authentication                                          |
| `:grafanacom_enabled`                             | True, False   | `false`                     | Grafana.com Authentication                                          |
| `:grafanacom_allow_sign_up`                       | True, False   | `true`                      | Grafana.com Authentication                                          |
| `:grafanacom_client_id`                           | String        |                             | Grafana.com Authentication                                          |
| `:grafanacom_client_secret`                       | String        |                             | Grafana.com Authentication                                          |
| `:grafanacom_scopes`                              | String        | `user:email`                | Grafana.com Authentication                                          |
| `:grafanacom_allowed_organizations`               | String        |                             | Grafana.com Authentication                                          |
| `:generic_oauth_name`                              | String        | `OAuth`                     | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_enabled`                           | True, False   | `false`                     | Enable Generic OAuth                                                | true, false
| `:generic_oauth_allow_sign_up`                     | True, False   | `true`                      | <http://docs.grafana.org/auth/generic-oauth/>                         | true, false
| `:generic_oauth_client_id`                         | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_client_secret`                     | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_scopes`                            | String        | `user:email`                | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_email_attribute_name`              | String        | `email:primary`             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_auth_url`                          | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_token_url`                         | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_api_url`                           | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_team_ids`                          | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_allowed_organizations`             | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_tls_skip_verify_insecure`          | True, False   | `false`                     | <http://docs.grafana.org/auth/generic-oauth/>                         | true, false
| `:generic_oauth_tls_client_cert`                   | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_tls_client_key`                    | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_tls_client_ca`                     | String        |                             | <http://docs.grafana.org/auth/generic-oauth/>                         |
| `:generic_oauth_send_client_credentials_via_post`  | True, False   | `false`                     | <http://docs.grafana.org/auth/generic-oauth/>                         | true, false
| `:basic_enabled`                                  | True, False   | `true`                      | Basic auth is enabled by default and works with the built in Grafana user password authentication system and LDAP authentication integration| true, false
| `:proxy_enabled`                                  | True, False   | `false`                     | Defaults to false, but set to true to enable this feature (http://docs.grafana.org/auth/auth-proxy/)| true, false
| `:proxy_header_name`                              | String        | `X-WEBAUTH-USER`            | HTTP Header name that will contain the username or email            |
| `:proxy_header_property`                          | String        | `username`                  | HTTP Header property, defaults to `username` but can also be `email`|
| `:proxy_auto_sign_up`                             | True, False   |  `true`                     | Set to `true` to enable auto sign up of users who do not exist in Grafana DB. Defaults to `true`.| true, false
| `:proxy_ldap_sync_ttl`                            |  Integer      | `60`                        | If combined with Grafana LDAP integration define sync interval      |
| `:proxy_whitelist`                                | String        |                             | Limit where auth proxy requests come from by configuring a list of IP addresses|
| `:proxy_headers`                                  | String        |                             | Optionally define more headers to sync other user attributes        |
| `:ldap_enabled`                                   | True, False   | `false`                     | Set to `true` to enable LDAP integration (http://docs.grafana.org/auth/ldap/)| true, false
| `:ldap_config_file`                               | String        | `/etc/grafana/ldap.toml`    | Path to the LDAP specific configuration file                        |
| `:ldap_allow_sign_up`                             | True, False   | `true`                      | Allow sign up should almost always be true (default) to allow new Grafana users to be created| true, false
| `conf_directory`                                  | String        | `/etc/grafana`              | The directory where the Grafana configuration resides| Valid directory
| `config_file`                                     | String        | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                      | Valid file path
| `cookbook`                                        | String        | `grafana`                   | Which cookbook to look in for the template                          |
| `source`                                          | String        | `grafana.ini.erb`           | Name of the template                                                |
