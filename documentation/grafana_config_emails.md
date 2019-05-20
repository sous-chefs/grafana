[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_emails

Configures the core emails section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `welcome_email_on_sign_up`| true, false   | `false`                     | Sends emails on signup                                                    | true, false
| `templates_pattern`       | String        | `emails/*.html`             | E-mail templates                                                          |
| `conf_directory`          | String        | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String        | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_emails 'grafana'
```

```ruby
grafana_config_emails 'grafana' do
  welcome_email_on_sign_up true
end
```
