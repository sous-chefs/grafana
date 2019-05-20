[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_server

Configures the core server section of the configuration <http://docs.grafana.org/installation/configuration/#server>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                | Type        |  Default                                  | Description                                             | Allowed Values
| ------------------- | ----------- | ----------------------------------------- | ------------------------------------------------------- | --------------- |
| `protocol`          | String      | `http`                                    | Protocol to use                                         |http https socket
| `http_addr`         | String      |                                           | The IP address to bind to. If empty will bind to all interfaces|
| `http_port`         | Integer     | `3000`                                    | The port to bind to, Privilaged ports will need you to add additional permissions|
| `domain`            | String      | `node['hostname']`                        | This setting is only used in as a part of the root_url setting |
| `root_url`          | String      | `%(protocol)s://%(domain)s:%(http_port)s/`| This is the full URL used to access Grafana from a web browser|
| `enforce_domain`    | true, false | `false`                                   | Redirect to correct domain if host header does not match domain. Prevents DNS rebinding attacks. Default is false.|
| `router_logging`    | true, false | `false`                                   | Set to true for Grafana to log all HTTP requests (not just errors). | true, false
| `static_root_path`  | String      | `public`                                  | The path to the directory where the front end files (HTML, JS, and CSS files)|
| `enable_gzip`       | true, false | `false`                                   | Set this option to true to enable HTTP compression.  | true, false
| `cert_file`         | String      |                                           | Path to the certificate file (if protocol is set to https).  |
| `cert_key`          | String      |                                           | Path to the certificate key file (if protocol is set to https).  |
| `conf_directory`    | String      | `/etc/grafana`                            | The directory where the Grafana configuration resides   | Valid directory
| `config_file`       | String      | `/etc/grafana/grafana.ini`                | The Grafana configuration file                          | Valid file path
| `cookbook`          | String      | `grafana`                                 | Which cookbook to look in for the template              |
| `source`            | String      | `grafana.ini.erb`                         | Name of the template                                    |

## Examples

```ruby
grafana_config_server 'grafana'
```

```ruby
grafana_config_server 'grafana' do
  protocol 'http'
  root_url 'grafana.example.com'
  enable_gzip true
end
```
