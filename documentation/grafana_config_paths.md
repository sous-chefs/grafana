[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_paths

Configures the core paths section of the configuration <http://docs.grafana.org/installation/configuration/#paths>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type     |  Default                    | Description                                                               | Allowed Values
| ------------------------- | -------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `data`                    | String   | `/var/lib/grafana`          | Path to where Grafana stores it's data                                    | Valid Directory
| `temp_data_lifetime`      | String   | `24h`                       | How long temporary images in data directory should be kept                |
| `logs`                    | String   | `/var/log/grafana`          | Path to where Grafana will store logs                                     |
| `plugins`                 | String   | `/var/lib/grafana/plugins`  | Directory where grafana will automatically scan and look for plugins      |
| `provisioning`            | String   | `conf/provisioning`         | Folder that contains provisioning config files that grafana will apply on startup|
| `conf_directory`          | String   | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String   | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String   | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String   | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_paths 'grafana'
```

```ruby
grafana_config_paths 'grafana' do
  data '/data/grafana'
  logs '/data/grafana/logs'
end
```
