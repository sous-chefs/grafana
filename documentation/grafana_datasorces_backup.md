[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_datasources_backup

This resource will allow you to backup all Grafana datasources to a folder by org.

## Actions

- `:create`

## Properties

| Name                  | Type        |  Default      | Description                                               | Allowed Values
| --------------------- | ----------- | ------------- | --------------------------------------------------------- | --------------- |
| `host`                |  String     | `localhost`   | The host grafana is running on|
| `port`                |  Integer    | `3000`        | The port grafana is running on|
| `admin_user`          |  String     | `admin`       | A grafana user with admin privileges|
| `admin_password`      |  String     | `admin`       | The grafana user's password|
| `auth_proxy_header`   |  String     | nil           | The HTTP authentication header used when `auth.proxy.enabled=true`. See [grafana_config_auth:proxy_header_name](grafana_config_auth.md)|
| `backup_path`         |  String     | `/etc/grafana/backup/datasources` | Path to store the backup |
| `clean_folder`        |  True, False| True | Delete the backup folder before saving datasources from grafana |
| `sensitive`           |  True, False| True | Do not show the json output of dashboards when backing up |

## Examples

```ruby
grafana_datasources_backup 'Backup Dashboards to File'
```
