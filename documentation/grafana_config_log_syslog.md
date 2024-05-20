# grafana_config_log_syslog

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the log.syslog section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#logsyslog>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name       | Type   | Default | Description                                                                                                             | Allowed Values                         |
| ---------- | ------ | ------- | ----------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| `level`    | String |         | Log level override for syslog only                                                                                      |                                        |
| `format`   | String |         | log line format                                                                                                         | text console json                      |
| `network`  | String |         | Syslog network type and address. This can be udp, tcp, or unix. If left blank, the default unix endpoints will be used. |                                        |
| `address`  | String |         | Syslog network type and address. This can be udp, tcp, or unix. If left blank, the default unix endpoints will be used. |                                        |
| `facility` | String |         | Syslog facility                                                                                                         | user, daemon and local0 through local7 |
| `tag`      | String |         | Syslog tag. By default, the process' argv[0] is used                                                                    |                                        |
