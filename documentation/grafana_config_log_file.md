# grafana_config_log_file

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the log.file section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#logfile>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name             | Type        | Default | Description                                            | Allowed Values    |
| ---------------- | ----------- | ------- | ------------------------------------------------------ | ----------------- |
| `level`          | String      |         | Log level override for file only                       |                   |
| `format`         | String      |         | log line format                                        | text console json |
| `log_rotate`     | true, false |         | Enables automated log rotate                           | true, false       |
| `max_lines`      | Integer     |         | Max line number of single file                         |                   |
| `max_size_shift` | Integer     |         | Max size shift of single file, 28 means 1 << 28, 256MB |                   |
| `daily_rotate`   | true, false |         | Segment log daily                                      | true, false       |
| `max_days`       | Integer     |         | Expired days of log file(delete after max days)        |                   |
