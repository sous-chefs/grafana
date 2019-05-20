[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_datasource

You can control Grafana dataSources via the `grafana_datasource`. Due to the varying nature of the potential data sources, the information used to create the datasource is consumed by the resource as a Hash (the `source` attribute). The examples should illustrate the flexibility. The full breadth of options are (or will be) documented on <http://docs.grafana.org/reference/http_api/#data-sources>, however you can discover undocumented parameters by inspecting the HTTP requests your browser makes to the Grafana server.

## Actions

- `:create`
- `:update`
- `:delete`

## Properties

| Name                  | Type        |  Default      | Description                                               | Allowed Values
| --------------------- | ----------- | ------------- | --------------------------------------------------------- | --------------- |
| `host`                | String      | `localhost`   | The host grafana is running on|
| `port`                | Integer     | `3000`        | The port grafana is running on|
| `admin_user`          | String      | `admin`       | A grafana user with admin privileges|
| `admin_password`      | String      | `admin`       | The grafana user's password|
| `auth_proxy_header`   | String      | nil           | The HTTP authentication header used when `auth.proxy.enabled=true`. See [grafana_config_auth:proxy_header_name](grafana_config_auth.md)|
| `datasource`          | Hash        | `{}`          | A Hash of the values to create the datasource. Examples below.|

## Examples

You can create a data source for Graphite as follows:

```ruby
grafana_datasource 'graphite-test' do
  datasource(
    type: 'graphite',
    url: 'http://10.0.0.15:8080',
    access: 'direct'
  )
end
```

You can create a data source for InfluxDB 0.8.x and make it the default dashboard as follows:

```ruby
grafana_datasource 'influxdb-test' do
  datasource(
    type: 'influxdb_08',
    url: 'http://10.0.0.10:8086',
    access: 'proxy',
    database: 'metrics',
    user: 'dashboard',
    password: 'dashpass',
    isdefault: true
  )
  action :create
end
```

Based on you version of `Grafana`, value for the `type` key to use `InfluxDB 0.9.x`, need to be `'influxdb'` instead of `'influxdb_08'`.

You can update an existing datasource as follows:

```ruby
grafana_datasource 'influxdb-test' do
  datasource(
    type: 'influxdb_09',
    url: 'http://10.0.0.10:8086',
    access: 'proxy',
    database: 'metrics',
    user: 'dashboard',
    password: 'dashpass',
    isdefault: true
  )
  action :create
end
```

And even rename it:

```ruby
grafana_datasource 'influxdb-test' do
  datasource(
    name: 'influxdb test',
    type: 'influxdb_08',
    url: 'http://10.0.0.10:8086',
    access: 'proxy',
    database: 'metrics',
    user: 'dashboard',
    password: 'dashpass',
    isdefault: true
  )
  action :create
end
```

Finally, you can also delete a datasource:

```ruby
grafana_datasource 'influxdb-test' do
  action :delete
end
```
