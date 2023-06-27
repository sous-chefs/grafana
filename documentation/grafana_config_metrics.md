# grafana_config_metrics

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core metrics section of the configuration <http://docs.grafana.org/installation/configuration/#metrics>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                  | Type        | Default | Description                                                                             | Allowed Values |
| --------------------- | ----------- | ------- | --------------------------------------------------------------------------------------- | -------------- |
| `enabled`             | true, false | `false` | Enable metrics reporting                                                                | true, false    |
| `basic_auth_username` | String      |         | If set configures the username to use for basic authentication on the metrics endpoint. |                |
| `basic_auth_password` | String      |         | If set configures the password to use for basic authentication on the metrics endpoint. |                |
| `interval_seconds`    | Integer     | `10`    | Flush/Write interval when sending metrics to external TSDB. Defaults to 10s.            |                |

## Examples

```ruby
grafana_config_metrics 'grafana'
```

```ruby
grafana_config_metrics 'grafana' do
  basic_auth_username 'grafana_user'
  basic_auth_password 'MySuperSecretPassword'
end
```
