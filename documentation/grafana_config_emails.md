[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_emails

Configures the core emails section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

`:install`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `welcome_email_on_sign_up`| true, false   | `false`                     | Sends emails on signup                                                    | true, false
| `templates_pattern`       | String        | `emails/*.html`             | E-mail templates                                                          |

## Examples

```ruby
grafana_config_emails 'grafana'
```

```ruby
grafana_config_emails 'grafana' do
  welcome_email_on_sign_up true
end
```
