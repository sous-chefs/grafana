[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_dataproxy

Configures the core dataproxy section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                              | Type        | Default | Description                                                                                                                                                                                                                                                         | Allowed Values |
| --------------------------------- | ----------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| `logging`                         | true, false | `false` | This enables data proxy logging                                                                                                                                                                                                                                     | true, false    |
| `timeout`                         | Integer     | `false` | How long the data proxy should wait before timing out. Default is 30 seconds.                                                                                                                                                                                       |                |
| `keep_alive_seconds`              | Integer     | `false` | Interval between keep-alive probes. Default is 30 seconds. For more details check the Dialer.KeepAlive documentation.                                                                                                                                               |                |
| `tls_handshake_timeout_seconds`   | Integer     | `false` | The length of time that Grafana will wait for a successful TLS handshake with the datasource. Default is 10 seconds.                                                                                                                                                |                |
| `expect_continue_timeout_seconds` | Integer     | `false` | The length of time that Grafana will wait for a datasource’s first response headers after fully writing the request headers, if the request has an “Expect: 100-continue” header. A value of 0 will result in the body being sent immediately. Default is 1 second. |                |
| `max_conns_per_host`              | Integer     | `false` | Optionally limits the total number of connections per host, including connections in the dialing, active, and idle states. On limit violation, dials are blocked. A value of 0 means that there are no limits. Default is 0.                                        |                |
| `max_idle_connections`            | Integer     | `false` | The maximum number of idle connections that Grafana will maintain. Default is 100.                                                                                                                                                                                  |                |
| `max_idle_connections_per_host`   | Integer     | `false` | The maximum number of idle connections per host that Grafana will maintain. Default is 2.                                                                                                                                                                           |                |
| `idle_conn_timeout_seconds`       | Integer     | `false` | The length of time that Grafana maintains idle connections before closing them. Default is 90 seconds. logging                                                                                                                                                      |                |
| `send_user_header`                | true, false | `false` | If enabled and user is not anonymous, data proxy will add X-Grafana-User header with username into the request. Default is false.logging                                                                                                                            | true, false    |

## Examples

```ruby
grafana_config_dataproxy 'grafana'
```

```ruby
grafana_config_dataproxy 'grafana' do
  logging true
end
```
