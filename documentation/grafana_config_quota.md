[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_quota

Configures the core quotas section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                | Type        | Default | Description                                                                                  | Allowed Values |
| ------------------- | ----------- | ------- | -------------------------------------------------------------------------------------------- | -------------- |
| `enabled`           | true, false | `false` | Enable Quotas                                                                                | true, false    |
| `org_user`          | Integer     | `10`    | limit number of users per Org.                                                               |                |
| `org_dashboard`     | Integer     | `100`   | limit number of dashboards per Org.                                                          |                |
| `org_data_source`   | Integer     | `10`    | limit number of data_sources per Org.                                                        |                |
| `org_api_key`       | Integer     | `10`    | limit number of api_keys per Org.                                                            |                |
| `user_org`          | Integer     | `10`    | limit number of orgs a user can create.                                                      |                |
| `global_user`       | Integer     | `-1`    | global limit of users.                                                                       |                |
| `global_org`        | Integer     | `-1`    | global limit of orgs.                                                                        |                |
| `global_dashboard`  | Integer     | `-1`    | global limit of dashboards.                                                                  |                |
| `global_api_key`    | Integer     | `-1`    | global limit of api_keys.                                                                    |                |
| `global_session`    | Integer     | `-1`    | global limit on number of logged in users.                                                   |                |
| `global_alert_rule` | Integer     | `-1`    | Sets a global limit on number of alert rules that can be created. Default is -1 (unlimited). |                |

## Examples

```ruby
grafana_config_quota 'grafana'
```

```ruby
grafana_config_quota 'grafana' do
  enabled true
  org_user 50
  org_dashboard 200
  org_api_key 2
  global_api_key 4
end
```
