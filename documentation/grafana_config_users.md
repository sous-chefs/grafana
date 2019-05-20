[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_users

Configures the core users section of the configuration <http://docs.grafana.org/installation/configuration/#users>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type        |  Default                    | Description                                               | Allowed Values
| ------------------------- | ----------- | --------------------------- | --------------------------------------------------------- | --------------- |
| `allow_sign_up`           | true, false | `false`                     | Set to false to prohibit users from being able to sign up / create user accounts| true, false
| `allow_org_create`        | true, false | `false`                     | Set to false to prohibit users from creating new organizations | true, false
| `auto_assign_org`         | true, false | `true`                      | Set to true to automatically add new users to the main organization (id 1).| true, false
| `auto_assign_org_id`      | Integer     | `1`                         | Set this value to automatically add new users to the provided org. This requires auto_assign_org to be set to true. |
| `auto_assign_org_role`    | String      | `Viewer`                    | The role new users will be assigned for the main organization|
| `verify_email_enabled`    | true, false | `false`                     |  Require email validation before sign up completes        | true, false
| `login_hint`              | String      | `email or username`         | Login hint text                                           |
| `default_theme`           | String      | `dark`                      | Default user theme                                        | dark light
| `external_manage_link_url`| String      |                             | External user management                                  |
| `external_manage_link_name`|String      |                             | External user management                                  |
| `external_manage_info`    | String      |                             | External user management                                  |
| `viewers_can_edit`        | true, false | `false`                     | Viewers can edit/inspect dashboard settings in the browser| true, false
| `conf_directory`          | String      | `/etc/grafana`              | The directory where the Grafana configuration resides     | Valid directory
| `config_file`             | String      | `/etc/grafana/grafana.ini`  | The Grafana configuration file                            | Valid file path
| `cookbook`                | String      | `grafana`                   | Which cookbook to look in for the template                |
| `source`                  | String      | `grafana.ini.erb`           | Name of the template                                      |

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
  default_theme 'light'
end
```
