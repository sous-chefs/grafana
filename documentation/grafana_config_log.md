[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_log

Configures the core log section of the configuration <http://docs.grafana.org/installation/configuration/#log>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name      | Type   | Default | Description                                                     | Allowed Values      |
| --------- | ------ | ------- | --------------------------------------------------------------- | ------------------- |
| `mode`    | String |         | Either console file syslog Use space to separate multiple modes | console file syslog |
| `level`   | String |         | Logging level                                                   |                     |
| `filters` | String |         | optional settings to set different levels for specific loggers  |                     |

## Examples

```ruby
grafana_config_log 'grafana'
```

```ruby
grafana_config_log 'grafana' do
  mode 'console file'
  level 'debug'
  file_format 'json'
  file_daily_rotate true
  file_max_days 30
end
```
