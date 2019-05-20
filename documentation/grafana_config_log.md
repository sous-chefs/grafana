[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_log

Configures the core log section of the configuration <http://docs.grafana.org/installation/configuration/#log>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `mode`                    | String        | `console file`              | Either console file syslog Use space to separate multiple modes           | console file syslog
| `level`                   | String        | `info`                      | Logging level                                                             |
| `filters`                 | String        |                             | optional settings to set different levels for specific loggers            |
| `console_level`           | String        |                             | Log level override for console only                                       |
| `console_format`          | String        | `console`                   | log line format                                                           | text console json
| `file_level`              | String        |                             | Log level override for file only                                          |
| `file_format`             | String        | `text`                      | log line format                                                           | text console json
| `file_log_rotate`         | true, false   | `true`                      | Enables automated log rotate                                              | true, false
| `file_max_lines`          | Integer       | `1000000`                   | Max line number of single file                                            |
| `file_max_size_shift`     | Integer       | `28`                        | Max size shift of single file, 28 means 1 << 28, 256MB                    |
| `file_daily_rotate`       | true, false   | `true`                      | Segment log daily                                                         | true, false
| `file_max_days`           | Integer       | `7`                         | Expired days of log file(delete after max days)                           |
| `syslog_level`            | String        |                             | Log level override for syslog only                                        |
| `syslog_format`           | String        | `text`                      | log line format                                                           | text console json
| `syslog_network`          | String        |                             | Syslog network type and address. This can be udp, tcp, or unix. If left blank, the default unix endpoints will be used.  |
| `syslog_address`          | String        |                             | Syslog network type and address. This can be udp, tcp, or unix. If left blank, the default unix endpoints will be used.  |
| `syslog_facility`         | String        |                             | Syslog facility                                                           |user, daemon and local0 through local7
| `syslog_tag`              | String        |                             | Syslog tag. By default, the process' argv[0] is used                      |
| `conf_directory`          | String        | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String        | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

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
