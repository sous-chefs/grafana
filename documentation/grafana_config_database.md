# grafana_config_database

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core database section of the configuration <http://docs.grafana.org/installation/configuration/#database>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                | Type                | Default      | Description                                                                                                                      | Allowed Values         |
| ------------------- | ------------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| `type`              | Symbol              | `:sqlite3`   | Which type of database                                                                                                           | mysql postgres sqlite3 |
| `host`              | String              |              | Database host Only applicable to MySQL or Postgres                                                                               |
| `database_name`     | String              |              | Name of the database                                                                                                             |
| `user`              | String              |              | Username to authenticate with                                                                                                    |
| `password`          | String              |              | Password to authenticate with                                                                                                    |
| `max_idle_conn`     | Integer             |              | The maximum number of connections in the idle connection pool.                                                                   |
| `max_open_conn`     | Integer             |              | The maximum number of open connections to the database.                                                                          |
| `conn_max_lifetime` | Integer             | `14400`      | Sets the maximum amount of time a connection may be reused                                                                       |
| `log_queries`       | true, false         | `false`      | Set to true to log the sql calls and execution times                                                                             | true, false            |
| `ssl_mode`          | Symbol, true, false |              | For Postgres, use either `:disable`, `:require` or `:'verify-full'`. For MySQL, use either `true`, `false`, or `:'skip-verify'`. |
| `ca_cert_path`      | String              |              | The path to the CA certificate to use.                                                                                           |
| `client_key_path`   | String              |              | The path to the client key. Only if server requires client authentication                                                        |
| `server_cert_name`  | String              |              | The path to the client cert. Only if server requires client authentication                                                       |
| `path`              | String              | `grafana.db` | Only applicable for sqlite3 database. The file path where the database will be stored                                            |
| `cache_mode`        | String              |              | For “sqlite3” only. Shared cache setting used for connecting to the database. (private, shared) Defaults to private.             |

## Examples

```ruby
grafana_config_database 'grafana'
```

```ruby
grafana_config_database 'grafana' do
  type :sqlite3
  path my.db
end
```

```ruby
grafana_config_database 'grafana' do
  type :mysql
  host 127.0.0.1:3306
  user 'grafana_user'
  password 'MySuperSecretPassword'
  max_idle_conn 10
  max_open_conn 30
  ssl_mode false
end
```

```ruby
grafana_config_database 'grafana' do
  type :postgres
  host 127.0.0.1:5432
  user 'grafana_user'
  password 'MySuperSecretPassword'
  max_idle_conn 10
  max_open_conn 30
  ssl_mode :disabled
end
```
