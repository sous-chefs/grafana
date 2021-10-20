# Grafana Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/grafana.svg?style=flat)](https://supermarket.chef.io/cookbooks/grafana)
[![CI State](https://github.com/sous-chefs/grafana/workflows/ci/badge.svg)](https://github.com/sous-chefs/grafana/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

## Description

This cookbook provides a complete installation and configuration of Grafana. This includes the ability to manage dashboards, datasources, organizations, plugins and users with Chef via Custom Resources.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

| Attribute                                    | Default                                | Description                       |
|----------------------------------------------|:--------------------------------------:|-----------------------------------|
| `node['grafana']['manage_install']`          | `true`                                 | Whether or not the installation should be managed by this cookbook. |
| `node['grafana']['install_type']`            | `'file'`                               | The type of install: `file`, `package` or `source`. *Note*: `source` is not currently supported. |
| `node['grafana']['version']`                 | `'2.1.2'`                              | The version to install. For the most recent versions use `'latest'`. |
| `node['grafana']['file']['url']`             | `'https://grafanarel.s3.amazonaws.com/builds/grafana'` | The file URL for Grafana builds |
| `node['grafana']['file']['checksum']['deb']` | `'57f52cc8e510f395f7f15caac841dc31e67527072fcbf5cc2d8351404989b298'` | The SHA256 checksum of Grafana .deb file |
| `node['grafana']['file']['checksum']['rpm']` | `'618f5361e594b101a4832a67a9d82f1179c35ff158ef4288dc1f8b6e8de67bb8'` | The SHA256 checksum of Grafana .rpm file |
| `node['grafana']['package']['repo']`         | `'https://packagecloud.io/grafana/stable/'` | The grafana package repo |
| `node['grafana']['package']['key']`          | `'https://packagecloud.io/gpg.key'`    | The package repo GPG key |
| `node['grafana']['package']['components']`   | `['main']`                             | The package repo components |
| `node['grafana']['user']`                    | `'grafana'`                            | The grafana user |
| `node['grafana']['group']`                   | `'grafana'`                            | The grafana group |
| `node['grafana']['home']`                    | `'/usr/share/grafana'`                 | The value set to GRAFANA_HOME |
| `node['grafana']['data_dir']`                | `'/var/lib/grafana'`                   | The path grafana can use to store temp files, sessions, and the sqlite3 db |
| `node['grafana']['log_dir']`                 | `'/var/log/grafana'`                   | Grafana's log directory |
| `node['grafana']['plugins_dir']`             | `'/var/lib/grafana/plugins'`           | Grafana's plugins directory |
| `node['grafana']['env_dir']`                 | `'/etc/default'` or `'/etc/sysconfig'` | The location for environment variables - autoconfigured for rhel and debian systems |
| `node['grafana']['conf_dir']`                | `'/etc/grafana'`                       | The location to store the `grafana.ini` file |
| `node['grafana']['restart_on_upgrade']`      | `false`                                | Whether or not to restart the service on upgrade when installing form packages |
| `node['grafana']['webserver']`               | `'nginx'`                              | Which webserver to use: `'nginx'` or `''` |
| `node['grafana']['webserver_hostname']`      | `node.name`                            | The server_name used in the webserver config |
| `node['grafana']['webserver_aliases']`       | `[node['ipaddress']]`                  | Array of any secondary hostnames that are valid vhosts |
| `node['grafana']['webserver_listen']`        | `node['ipaddress']`                    | The ip address the web server will listen on |
| `node['grafana']['webserver_port']`          | `80`                                   | The port the webserver will listen on |
| `node['grafana']['cli_bin']`                 | `/usr/sbin/grafana-cli`                | The path to the grafana-cli binary |
| `node['grafana']['plugins']`                 | `empty`                                | Array of plugins to install |
| `node['grafana']['plugins_action']`          | `:install`                             | Action to run on the array of plugins (:install, :upgrade, ..) |

- Chef Client 13+

### Platforms

This cookbook officially supports and is tested against the following platforms:

- Ubuntu >= 16.04
- Debian >= 8
- CentOS/Redhat >= 6

PRs are welcome to add support for additional platforms.

## Configuration Resource Features

We supply many different configuration resources, these all rely on the base config resource being called

For any LDAP the base config resource is: `grafana_config_ldap`
For any core configuration resources, the base config resource is: `grafana_config`

**NOTE**: Inorder to write the above configuration resources to the disk use [grafana_config_writer](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_writer.md) at the end.

## Resources

- [grafana_config](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config.md)
- [grafana_config_alerting](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_alerting.md)
- [grafana_config_auth](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_auth.md)
- [grafana_config_auth_azuread](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_auth_azuread.md)
- [grafana_config_dashboards](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_dashboards.md)
- [grafana_config_database](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_database.md)
- [grafana_config_dataproxy](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_dataproxy.md)
- [grafana_config_emails](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_emails.md)
- [grafana_config_enterprise](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_enterprise.md)
- [grafana_config_explore](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_explore.md)
- [grafana_config_log](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_log.md)
- [grafana_config_ldap](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_ldap.md)
- [grafana_config_ldap_group_mappings](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_ldap_group_mappings.md)
- [grafana_config_ldap_servers](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_ldap_servers.md)
- [grafana_config_metrics](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_metrics.md)
- [grafana_config_panels](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_panels.md)
- [grafana_config_paths](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_paths.md)
- [grafana_config_plugins](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_plugins.md)
- [grafana_config_quota](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_quota.md)
- [grafana_config_remote_cache](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_remote_cache.md)
- [grafana_config_rendering](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_rendering.md)
- [grafana_config_security](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_security.md)
- [grafana_config_server](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_server.md)
- [grafana_config_session](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_session.md)
- [grafana_config_smtp](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_smtp.md)
- [grafana_config_snapshots](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_snapshots.md)
- [grafana\_config\_external\_image\_storage\_s3](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_external_image_storage_s3.md)
- [grafana_config_users](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_users.md)
- [grafana_config_writer](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_writer.md)
- [grafana_cookie_name](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_cookie_name.md)
- [grafana_dashboard](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_dashboard.md)
- [grafana_dashboard_template](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_dashboard_template.md)
- [grafana_dashboards_backup](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_dashboards_backup.md)
- [grafana_datasource](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_datasource.md)
- [grafana_datasources_backup](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_datasources_backup.md)
- [grafana_folder](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_folder.md)
- [grafana_install](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_install.md)
- [grafana_organization](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_organization.md)
- [grafana_plugin](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_plugin.md)
- [grafana_user](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_user.md)

## Note on default session cookie name change

The default cookie name changed from Grafana [5.4.5](https://github.com/grafana/grafana/blob/v5.4.5/pkg/setting/setting.go#L743) to [6.0.0](https://github.com/grafana/grafana/blob/v6.0.0/pkg/setting/setting.go#L664).  The name change was from `grafana_sess` to `grafana_session`.  This cookbook now defaults to `grafana_session`.  This can be a breaking change, so please be aware of this.  Please see the [`grafana_cookie_name` documentation](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_cookie_name.md) for details

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

#### grafana::plugins
This recipe will install or upgrade the plugins given with the `node['grafana']['plugins']` attribute

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

### grafana_datasource
You can control Grafana dataSources via the `grafana_datasource` LWRP. Due to the varying nature of the potential data sources, the information used to create the datasource is consumed by the resource as a Hash (the `source` attribute). The examples should illustrate the flexibility. The full breadth of options are (or will be) documented on the [Grafana website](http://docs.grafana.org/reference/http_api/#data-sources), however you can discover undocumented parameters by inspecting the HTTP requests your browser makes to the Grafana server.

#### Attributes
| Attribute       | Type     | Default Value     | Description                                                    |
|-----------------|:--------:|:-----------------:|----------------------------------------------------------------|
| `host`          | `String` | `'localhost'`     | The host grafana is running on                                 |
| `port`          | `Integer`| `3000`            | The port grafana is running on                                 |
| `admin_user`    | `String` | `'admin'`         | A grafana user with admin privileges                           |
| `admin_password`| `String` | `'admin'`         | The grafana user's password                                    |
| `datasource`    | `Hash  ` | `{}`              | A Hash of the values to create the datasource. Examples below. |
| `action`        | `String` | `create`          | Valid actions are `create`, `update`, and `delete`.            |


#### Examples
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

Based on you version of `Grafana`, value for the `type` key to use `InfluxDB 0.9.x`, need to be
`'influxdb'` instead of `'influxdb_08'`.

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

### grafana_provisioning_datasource
Since Grafana 5.0, tt’s possible to manage datasources in Grafana by adding one or more yaml config files in the provisioning/datasources directory. Each config file can contain a list of datasources that will be added or updated during start up. 

You can create a data source for Graphite 1.1 as follows:
```ruby
grafana_provisioning_datasource 'graphite-test' do
  action :create
  datasource(
    name: 'graphite-test',
    type: 'graphite',
    url: 'http://10.0.0.15:8080',
    organization_id: 1,
    access: 'direct',
    json_data: { tlsAuth: false, tlsAuthWithCACert: false, graphiteVersion: 1.1 },
  )
end
```

Finally, you can also delete a datasource:
```ruby
grafana_provisioning_datasource 'graphite-test' do
  action :delete
  datasource(
    name: 'graphite-test',
    organization_id: 1,
  )
end
```

### grafana_dashboard
Dashboards in Grafana are always going to be incredibly specific to the application, but you may want to be able to create a new dashboard along with a newly provisioned stack. This resource assumes you have a static json file that displays the information that will be flowing from the newly created stack.

This resource currently makes an assumption that the name used in invocation matches the name of the dashboard. This will obviously have limitations, and could change in the future. More documentation on creating Grafana dashboards via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#dashboards).

#### Attributes
| Attribute        | Type     | Default Value       | Description                                                                                                              |
|------------------|:--------:|:-------------------:|--------------------------------------------------------------------------------------------------------------------------|
| `host`           | `String` | `'localhost'`       | The host grafana is running on                                                                                           |
| `port`           | `Integer`| `3000`              | The port grafana is running on                                                                                           |
| `admin_user`     | `String` | `'admin'`           | A grafana user with admin privileges                                                                                     |
| `admin_password` | `String` | `'admin'`           | The grafana user's password                                                                                              |
| `dashboard`      | `String` |                     | A Hash of the values to create the dashboard. Examples below.                                                            |
| `action`         | `String` | `create` | Valid actions are `create`, `update`, and `delete`. Create can update the dashbord, be careful (see below for details) ! |

#### Examples
Assuming you have a `files/default/simple-dashboard.json`:

```ruby
grafana_dashboard 'simple-dashboard'
```

If you'd like to use a `my-dashboard.json` with the title `"title": "Test Dash"`:

```ruby
grafana_dashboard 'test-dash' do
  dashboard(
    source: 'my-dashboard',
    overwrite: false
  )
end
```

If the dashboard you would like to import is already on disk with the title `"title": "On Disk Dash"`:

```ruby
grafana_dashboard 'on-disk-dash' do
  dashboard(
    path: '/opt/grafana/dashboards/local-dash.json'
  )
end
```
You can update a dashboard. For that, you have 2 options:

Use `create` action with `overwrite` dashboard property, like:
```ruby
grafana_dashboard 'on-disk-dash' do
  dashboard(
    path: '/opt/grafana/dashboards/local-dash.json',
    overwrite: true
  )
  action :create
end
```

Or use `update` action, which will force `overwrite` dashboard property to true:
```ruby
grafana_dashboard 'on-disk-dash' do
  dashboard(
    path: '/opt/grafana/dashboards/local-dash.json'
  )
  action :update
end
```
Finally, you can delete a dashboard:
```ruby
grafana_dashboard 'test-dash' do
  action :delete
end
```

### grafana_organization
This resource will allow you to create organizations within Grafana.

More information about creating Grafana organizations via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#organizations).

#### Attributes
| Attribute      | Type     | Default Value       | Description                       |
|----------------|:--------:|:-------------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`       | The host grafana is running on    |
| `port`         | `Integer`| `3000`              | The port grafana is running on    |
| `admin_user`         | `String` | `'admin'`           | A grafana user with admin privileges |
| `admin_password`     | `String` | `'admin'`           | The grafana user's password       |
| `organization  | `Hash  ` | `{}`                | A Hash of the values to create the organization. Examples below. |
| `action`       | `String` | `create_if_missing` | Valid actions are `create`, `update` and `delete`. |

#### Examples
Assuming you would like to create a new organization called `Second Org.`:

```ruby
grafana_organization 'Second Org.'
```

You can also update an existing organization (usefull to change the name of the default organization):

```ruby
grafana_organization 'Main Org.' do
  organization(
    name: 'Main Org 2.'
  )
  action :update
end
```
You will finally be able to delete an organization (WARNING: this change is _NOT_ supported in Grafana 2.1.3):

```ruby
grafana_organization 'Second Org.' do
  action :delete
end
```

### grafana_user
This resource will allow you to create global users within Grafana. This resource is minimally viable and only supports the addition of global non-admin users. Contribution to the functionality would be appreciated.

More information about creating Grafana users via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#users).

#### Attributes
| Attribute        | Type     | Default Value       | Description                                              |
|------------------|:--------:|:-------------------:|----------------------------------------------------------|
| `host`           | `String` | `'localhost'`       | The host grafana is running on                           |
| `port`           | `Integer`| `3000`              | The port grafana is running on                           |
| `admin_user`     | `String` | `'admin'`           | A grafana user with admin privileges                     |
| `admin_password` | `String` | `'admin'`           | The grafana user's password                              |
| `user`           | `Hash  ` | `{}`                | A Hash of the values to create the user. Examples below. |
| `action`         | `String` | `create `           | Valid actions are `create`, `update`, `delete`.          |

#### Examples
Assuming you would like to create a new user...

```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test123',
    isAdmin: true
  )
  action :create
end
```
User's login property is not mandatory. Default goes to resource name.

To update user's details, password and permissions
```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test1234',
    isAdmin: false
  )
  action :update
end
```

To update user's login, use current login as resource name and new login as user property, like:
```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    login: 'john.smith',
    email: 'test@example.com',
    password: 'test1234',
    isAdmin: false
  )
  action :update
end
```

And finally to delete a user
```ruby
grafana_user 'john.smith' do
  action :delete
end
```

### grafana_plugin

This ressource will help you to manage grafana plugins.

#### Attributes
| Attribute        | Type     | Default Value       | Description                                              |
|------------------|:--------:|:-------------------:|----------------------------------------------------------|
| `name`           | `String` | `''`                | Name of the plugin.                                      |
| `action`         | `String` | `install`           | Valid actions are `install`, `update`, `remove`.         |
| `grafana_cli_bin` | `String` | `'/usr/sbin/grafana-cli'`               | The path to the grafana-cli binary                       |

#### Examples

```ruby
grafana_plugin grafana-clock-panel do
  action :install
  grafana_cli_bin '/usr/sbin/grafana-cli'
end
```

### grafana_alert_notification
You can control Grafana alert notifications via the `grafana_alert_notification` LWRP. Due to the varying nature of the potential alert notifications, the information used to create the alert motification is consumed by the resource as a Hash (the `source` attribute). The examples should illustrate the flexibility. The full breadth of options are (or will be) documented on the [Grafana website](http://docs.grafana.org/http_api/alerting/), however you can discover undocumented parameters by inspecting the HTTP requests your browser makes to the Grafana server.

#### Attributes
| Attribute            | Type     | Default Value     | Description                                                            |
|---------------------:|:--------:|:-----------------:|------------------------------------------------------------------------|
| `host`               | `String` | `'localhost'`     | The host grafana is running on                                         |
| `port`               | `Integer`| `3000`            | The port grafana is running on                                         |
| `admin_user`         | `String` | `'admin'`         | A grafana user with admin privileges                                   |
| `admin_password`     | `String` | `'admin'`         | The grafana user's password                                            |
| `alert_notification` | `Hash  ` | `{}`              | A Hash of the values to create the alert notification. Examples below. |
| `action`             | `String` | `create`          | Valid actions are `create`, `update`, and `delete`.                    |


#### Examples
You can create an alert notification for the Prometheus alertmanager as follows:

```ruby
grafana_alert_notification 'alertmanager-test' do
  alert_notification(
    type: 'prometheus-alertmanager',
    settings: { url: "http://alertmanager.local.test" },
  )
end
```

You can create an alert notification for email and make it the default dashboard as follows:

```ruby
grafana_alert_notification 'email-test' do
  alert_notification(
    type: 'email',
    settings: { addresses: "admin@local.test" },
    isdefault: true
  )
  action :create
end
```

Testing
-------
#### Foodcritic & Rubocop

```
$ bundle exec foodcritic -X spec -f any ./
$ bundle exec rubocop
```

#### ChefSpec

```
$ bundle exec rspec
```

#### kitchen-test

Requires Vagrant >= 1.7.

```
$ bundle install
$ bundle exec kitchen test
```

Contributing
------------
- Fork the repository on Github
- Create a named feature branch (like `add_component_x`)
- Write your change
- Write tests for your change (if applicable)
- Run the tests, ensuring they all pass -- `bundle exec strainer test`
- Submit a Pull Request using Github

License and Authors
-------------------
Primary authors:

- Jonathan Tron <jonathan@tron.name>
- Mike Lanyon <lanyonm@gmail.com>

Contributors:

- Grégoire Seux (@kamaradclimber)
- Anatoliy D. (@anatolijd)
- Greg Fitzgerald (@gregf)
- Fred Hatfull (@fhats)
- Tim Smith (@tas50)
- Jonathon W. Marshall (@jwmarshall)
- Andrew Goktepe (@andrewgoktepe)
- Miguel Landaeta (@nomadium)
- Bernhard Köhler (@drywheat)
- Olivier Bazoud (@obazoud)
- @osigida
- @BackSlasher
- Helio Campos Mello de Andrade (@HelioCampos)
- Arif Akram Khan (@arifcse019)
- Jean Baptiste Favre (@jbfavre)
- Miguel Moll (@MiguelMoll)
- ptQa (@ptqa)
- Danny (@kemra102)
- Dave Steinberg (@redterror)
- Roel Gerrits (@roelgerrits)
- Corentin Chary (@iksaif)
- @phoenixyz
- Ioannis Charitopoulos (@jinxcat)
- Joshua Zitting (@joshzitting)
- Angelo San Ramon (@angelosanramon)
- Dmitry (@cyberflow)
- Nilanjan Roy (@nilroy)
- Jon Henry (@jhenry82)
- akadoya (@akadoya)

Based on `chef-kibana` cookbook by:

- John E. Vincent <lusis.org+github.com@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
jhenry82
