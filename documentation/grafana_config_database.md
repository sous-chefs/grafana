[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_database

Configures the core database section of the configuration <http://docs.grafana.org/installation/configuration/#database>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `type`                    |  String       | `sqlite3`                   | Which type of database                                                    | mysql postgres sqlite3
| `host`                    |  String       | `127.0.0.1:3306`            | Database host Only applicable to MySQL or Postgres                        |
| `database_name`           |  String       | `grafana`                   | Name of the database                                                      |
| `user`                    |  String       | `root`                      | Username to authenticate with                                             |
| `password`                |  String       |                             | Password to authenticate with                                             |
| `max_idle_conn`           |  Integer      | `2`                         | The maximum number of connections in the idle connection pool.            |
| `max_open_conn`           |  Integer      | `0`                         | The maximum number of open connections to the database.                   |
| `conn_max_lifetime`       |  Integer      | `14400`                     | Sets the maximum amount of time a connection may be reused                |
| `log_queries`             |  true, false  | `false`                     | Set to true to log the sql calls and execution times                      | true, false
| `ssl_mode`                |  String       |                             | For Postgres, use either disable, require or verify-full. For MySQL, use either true, false, or skip-verify.|
| `ca_cert_path`            |  String       |                             | The path to the CA certificate to use.                                    |
| `client_key_path`         |  String       |                             | The path to the client key. Only if server requires client authentication |
| `server_cert_name`        |  String       |                             | The path to the client cert. Only if server requires client authentication|
| `path`                    |  String       | `grafana.db`                | Only applicable for sqlite3 database. The file path where the database will be stored.|
| `conf_directory`          | String        | `/etc/grafana`              | The directory where the Grafana configuration resides                     | Valid directory
| `config_file`             | String        | `/etc/grafana/grafana.ini`  | The Grafana configuration file                                            | Valid file path
| `cookbook`                | String        | `grafana`                   | Which cookbook to look in for the template                                |
| `source`                  | String        | `grafana.ini.erb`           | Name of the template                                                      |

## Examples

```ruby
grafana_config_database 'grafana'
```

```ruby
grafana_config_database 'grafana' do
  type sqlite3
  path my.db
end
```

```ruby
grafana_config_database 'grafana' do
  type mysql
  host 127.0.0.1:3306
  user 'grafana_user'
  password 'MySuperSecretPassword'
  max_idle_conn 10
  max_open_conn 30
  ssl_mode 'false'
end
```

```ruby
grafana_config_database 'grafana' do
  type postgres
  host 127.0.0.1:5432
  user 'grafana_user'
  password 'MySuperSecretPassword'
  max_idle_conn 10
  max_open_conn 30
  ssl_mode 'disabled'
end
```
