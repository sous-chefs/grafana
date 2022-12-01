# grafana__config_file

[Back to resource list](../README.md#resources)

## Actions

- `:create`
- `:delete`

## Properties

| Name                        | Name? | Type        | Default | Description | Allowed Values |
| --------------------------- | ----- | ----------- | ------- | ----------- | -------------- |
| `sensitive`                 |       | true, false |         |             |                |
| `conf_directory`            |       | String      |         |             |                |
| `config_file`               |       | String      |         |             |                |
| `load_existing_config_file` |       | true        |         |             |                |
| `cookbook`                  |       | String      |         |             |                |
| `source`                    |       | String      |         |             |                |
| `owner`                     |       | String      |         |             |                |
| `group`                     |       | String      |         |             |                |
| `filemode`                  |       | String      |         |             |                |
| `extra_options`             |       | Hash        |         |             |                |

## Libraries

- `Grafana::Cookbook::ConfigHelper`
- `Grafana::Cookbook::GrafanaConfigFile`
