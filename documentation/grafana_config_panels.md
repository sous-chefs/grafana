# grafana_config_panels

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core panels section of the configuration <http://docs.grafana.org/installation/configuration/#panels>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                    | Type        | Default | Description                                                                                                                        | Allowed Values |
| ----------------------- | ----------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| `enable_alpha`          | true, false | `false` | Set to true if you want to test panels that are not yet ready for general usage.                                                   | true, false    |
| `disable_sanitize_html` | true, false | `false` | If set to true Grafana will allow script tags in text panels. Not recommended as it enables XSS vulnerabilities. Default is false. | true, false    |

## Examples

```ruby
grafana_config_panels 'grafana'
```

```ruby
grafana_config_panels 'grafana' do
  enable_alpha true
end
```
