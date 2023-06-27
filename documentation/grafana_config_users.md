# grafana_config_users

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core users section of the configuration <http://docs.grafana.org/installation/configuration/#users>

Introduced: v4.0.0

## Actions

`:install`

## Properties

| Name                                | Type          | Default | Description                                                                                                         | Allowed Values |
| ----------------------------------- | ------------- | ------- | ------------------------------------------------------------------------------------------------------------------- | -------------- |
| `allow_sign_up`                     | true, false   |         | Set to false to prohibit users from being able to sign up / create user accounts                                    | true, false    |
| `allow_org_create`                  | true, false   |         | Set to false to prohibit users from creating new organizations                                                      | true, false    |
| `auto_assign_org`                   | true, false   |         | Set to true to automatically add new users to the main organization (id 1).                                         | true, false    |
| `auto_assign_org_id`                | Integer       |         | Set this value to automatically add new users to the provided org. This requires auto_assign_org to be set to true. |
| `auto_assign_org_role`              | String        |         | The role new users will be assigned for the main organization                                                       |
| `verify_email_enabled`              | true, false   |         | Require email validation before sign up completes                                                                   | true, false    |
| `login_hint`                        | String        |         | Login hint text                                                                                                     |
| `default_theme`                     | Symbol        |         | Default user theme                                                                                                  | dark light     |
| `external_manage_link_url`          | String        |         | External user management                                                                                            |
| `external_manage_link_name`         | String        |         | External user management                                                                                            |
| `external_manage_info`              | String        |         | External user management                                                                                            |
| `viewers_can_edit`                  | true, false   |         | Viewers can edit/inspect dashboard settings in the browser                                                          | true, false    |
| `editors_can_admin`                 | true, false   |         |                                                                                                                     | true, false    |
| `user_invite_max_lifetime_duration` | String        |         |                                                                                                                     | true, false    |
| `hidden_users`                      | String, Array |         |                                                                                                                     | true, false    |

## Examples

```ruby
grafana_config_users 'grafana'
```

```ruby
grafana_config_users 'grafana' do
  allow_sign_up true
  allow_org_create true
  auto_assign_org false
  verify_email_enabled true
  default_theme :light
end
```
