# grafana_config_unified_alerting

[back to resource list](https://github.com/sous-chefs/grafana#resources)

## Uses

- [partial/_config_file](partial/_config_file.md)

## Actions

- None

## Properties

| Name                                 | Name? | Type        | Default        | Description | Allowed Values |
| ------------------------------------ | ----- | ----------- | -------------- | ----------- | -------------- |
| `enabled`                            |       | true, false |                |             |                |
| `admin_config_poll_interval_seconds` |       | Integer     |                |             |                |
| `ha_listen_address`                  |       | String      | "0.0.0.0:9094" |             |                |
| `ha_peers`                           |       | String      |                |             |                |
| `ha_advertise_address`               |       | String      |                |             |                |
| `ha_peer_timeout`                    |       | String      | "15s           |             |                |
