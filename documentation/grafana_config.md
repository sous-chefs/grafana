[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config

Configures the core config section of the configuration <http://docs.grafana.org/installation/configuration/>
This must be called before any other config resources

Introduced: v4.0.0

## Actions

`:install`

## Properties

| Name                 | Type        | Default        | Description                                           | Allowed Values         |
| -------------------- | ----------- | -------------- | ----------------------------------------------------- | ---------------------- |
| `instance_name`      | String      |                | Name Property, name of the instance                   |                        |
| `env_directory`      | String      | `/etc/default` | Environment settings directory                        | Valid directory        |
| `owner`              | String      | `grafana`      | User to run as                                        |                        |
| `group`              | String      | `grafana`      | Group to run as                                       |                        |
| `restart_on_upgrade` | true, false | `false`        | Restart the server on package upgrade                 |                        |
| `app_mode`           | String      | `production`   | Application Mode                                      | production development |
| `conf_directory`     | String      | `/etc/grafana` | The directory where the Grafana configuration resides | Valid directory        |
| `cookbook`           | String      | `grafana`      | Which cookbook to look in for the template            |                        |
| `extra_options`      | Hash        | nil            | Extra options to render `grafana.ini`                 |                        |

## Examples

```ruby
grafana_config 'grafana'
```

```ruby
grafana_config 'grafana' do
  owner 'grafana'
  group 'grafana'
  restart_on_upgrade true
end
```
