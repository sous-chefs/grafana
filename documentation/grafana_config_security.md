[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_security

Configures the core security section of the configuration <http://docs.grafana.org/installation/configuration/#security>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                                        | Type        | Default | Description                                                                                      | Allowed Values                        |
| ------------------------------------------- | ----------- | ------- | ------------------------------------------------------------------------------------------------ | ------------------------------------- |
| `admin_user`                                | String      |         | default admin user, created on startup                                                           |
| `admin_password`                            | String      |         | default admin password                                                                           |
| `secret_key`                                | String      |         | used for signing.                                                                                |
| `login_remember_days`                       | Integer     |         | The number of days the keep me logged in / remember me cookie lasts.                             |
| `disable_gravatar`                          | true, false |         | disable gravatar profile images.                                                                 | true, false                           |
| `data_source_proxy_whitelist`               | String      |         | data source proxy whitelist                                                                      | ip_or_domain:port separated by spaces |
| `disable_brute_force_login_protection`      | true, false |         | disable protection against brute force login attempts.                                           | true, false                           |
| `allow_embedding`                           | true, false |         | Allows grafana to be embedded in an iframe                                                       | true, false                           |
| `cookie_secure`                             | true, false |         | Secures cookies if running behind https                                                          | true, false                           |
| `cookie_samesite`                           | String      |         | Sets `SameSite` cookie and Prevents the browser from sending this cookie along with CSS attacks. |
| `disable_initial_admin_creation`            | True, False |         |                                                                                                  |
| `strict_transport_security`                 | True, False |         |                                                                                                  |
| `strict_transport_security_max_age_seconds` | Integer     |         |                                                                                                  |
| `strict_transport_security_preload`         | True, False |        |                                                                                                  |
| `strict_transport_security_subdomains`      | True, False |         |                                                                                                  |
| `x_content_type_options`                    | True, False |         |                                                                                                  |
| `x_xss_protection`                          | True, False |         |                                                                                                  |
| `content_security_policy`                   | True, False |         |                                                                                                  |
| `content_security_policy_template`          | String      |         |                                                                                                  |

## Examples

```ruby
grafana_config_security 'grafana'
```

```ruby
grafana_config_security 'grafana' do
  admin_user 'someOtherUsername'
  admin_password 'MySuperSecretPassword'
  disable_gravatar true
  secret_key 'myNewLongStringaaaaaaaaaaaaaaa'
end
```
