[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_quotas

Configures the core quotas section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type        |  Default                    | Description                                             | Allowed Values
| ------------------------- | ----------- | --------------------------- | ------------------------------------------------------- | --------------- |
| `enabled`                 | true, false | `false`                     | Enable Quotas                                           | true, false
| `org_user`                | Integer     | `10`                        | limit number of users per Org.                          |
| `org_dashboard`           | Integer     | `100`                       | limit number of dashboards per Org.                     |
| `org_data_source`         | Integer     | `10`                        | limit number of data_sources per Org.                   |
| `org_api_key`             | Integer     | `10`                        | limit number of api_keys per Org.                       |
| `user_org`                | Integer     | `10`                        | limit number of orgs a user can create.                 |
| `global_user`             | Integer     | `-1`                        | global limit of users.                                  |
| `global_org`              | Integer     | `-1`                        | global limit of orgs.                                   |
| `global_dashboard`        | Integer     | `-1`                        | global limit of dashboards.                             |
| `global_api_key`          | Integer     | `-1`                        | global limit of api_keys.                               |
| `global_session`          | Integer     | `-1`                        | global limit on number of logged in users.              |
| `conf_directory`          | String      | `/etc/grafana`              | The directory where the Grafana configuration resides   | Valid directory
| `config_file`             | String      | `/etc/grafana/grafana.ini`  | The Grafana configuration file                          | Valid file path
| `cookbook`                | String      | `grafana`                   | Which cookbook to look in for the template              |
| `source`                  | String      | `grafana.ini.erb`           | Name of the template                                    |

## Examples

```ruby
grafana_config_quotas 'grafana'
```

```ruby
grafana_config_quotas 'grafana' do
  enabled true
  org_user 50
  org_dashboard 200
  org_api_key 2
  global_api_key 4
end
```
