# grafana_config_smtp

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core smtp section of the configuration <http://docs.grafana.org/installation/configuration/#smtp>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name              | Type        | Default                                                                                 | Description                                                | Allowed Values                                     |
| ----------------- | ----------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------------- |
| `enabled`         | true, false | `false`                                                                                 | Enable use of smtp/email                                   | true, false                                        |
| `host`            | String      | `localhost:25`                                                                          | smtp host                                                  |
| `user`            | String      |                                                                                         | In case of SMTP auth.                                      |
| `password`        | String      |                                                                                         | In case of SMTP auth.                                      |
| `cert_file`       | String      |                                                                                         | File path to a cert file                                   |
| `key_file`        | String      |                                                                                         | File path to a key file                                    |
| `skip_verify`     | true, false | `false`                                                                                 | Verify SSL for smtp server                                 | true, false                                        |
| `from_address`    | String      | `"admin@grafana-#{node['hostname']}.#{node['domain'].nil? ? 'local' : node['domain']}"` | Address used when sending out emails                       |
| `from_name`       | String      | `Grafana`                                                                               | Name to be used when sending out emails                    |
| `ehlo_identity`   | String      |                                                                                         | Name to be used as client identity for EHLO in SMTP dialog |
| `startTLS_policy` | String      |                                                                                         | Name to be used as client identity for EHLO in SMTP dialog | OpportunisticStartTLS MandatoryStartTLS NoStartTLS |

## Examples

```ruby
grafana_config_smtp 'grafana'
```

```ruby
grafana_config_smtp 'grafana' do
  enabled true
  host 'smtp.example.com:25'
  user 'grafana_user'
  password 'MySuperSecretPassword'
  from_address 'monitoring@example.com'
end
```
