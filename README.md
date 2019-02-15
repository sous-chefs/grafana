# Grafana Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/grafana.svg?style=flat)](https://supermarket.chef.io/cookbooks/grafana) [![CircleCI](https://circleci.com/gh/sous-chefs/grafana.svg?style=svg)](https://circleci.com/gh/sous-chefs/grafana) [![Cookbook Version](https://img.shields.io/cookbook/v/grafana.svg)](https://supermarket.chef.io/cookbooks/grafana)

## Overview

This cookbook provides a complete installation and configuration of Grafana. This includes the ability to manage dashboards, datasources, orginizations, plugins and users with Chef using Custom Resources.

## Requirements

### Chef Client

- Chef Client 13+

### Platforms

- Ubuntu >= 16.04
- Debian >= 8
- CentOS/Redhat >= 6

## Depreciation Warnings

All Recipes and attributes have been removed.

**NOTE**

This cookbook does nothing to generate the basic auth user/password file, you will have to make sure this file is created and is valid.

## Usage

## Resources

### grafana_install

Installs Grafana from the repositories, this will setup the correct apt/yum repo and install it, allows you to supply your own custom repository.

#### Properties

Property           |   Type    | Default Value                                                  | Description
----------------   | :-------: | :-----------:                                                  | --------------------------------------------------------------
`version`          | `String`  |   `nil`                                                        | Use if you want to install a specific version (Must exist in repo)
`repo`             | `String`  |   `https://packages.grafana.com/oss`                           | Base Repository
`key`              | `String`  |   `https://packages.grafana.com/gpg.key`                       | GPG Key for Debian
`rpm_key`          | `String`  |   `https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana`    | GPG key for RPM
`deb_distribution` |  `String` |   `stable`                                                     | Deb Distribution
`deb_components`   | `Array`   |   `['main']`                                                   | Deb Components

#### Examples

Installs Latest Grafana from official repository:

```ruby
grafana_install 'grafana' do
end
```

### grafana_datasource

You can control Grafana dataSources via the `grafana_datasource` LWRP. Due to the varying nature of the potential data sources, the information used to create the datasource is consumed by the resource as a Hash (the `source` attribute). The examples should illustrate the flexibility. The full breadth of options are (or will be) documented on the [Grafana website](http://docs.grafana.org/reference/http_api/#data-sources), however you can discover undocumented parameters by inspecting the HTTP requests your browser makes to the Grafana server.

#### Properties

Property         |   Type    | Default Value | Description
---------------- | :-------: | :-----------: | --------------------------------------------------------------
`host`           | `String`  | `'localhost'` | The host grafana is running on
`port`           | `Integer` |    `3000`     | The port grafana is running on
`admin_user`     | `String`  |   `'admin'`   | A grafana user with admin privileges
`admin_password` | `String`  |   `'admin'`   | The grafana user's password
`datasource`     |  `Hash`   |     `{}`      | A Hash of the values to create the datasource. Examples below.
`action`         | `String`  |   `create`    | Valid actions are `create`, `update`, and `delete`.

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

### grafana_dashboard

Dashboards in Grafana are always going to be incredibly specific to the application, but you may want to be able to create a new dashboard along with a newly provisioned stack. This resource assumes you have a static json file that displays the information that will be flowing from the newly created stack.

This resource currently makes an assumption that the name used in invocation matches the name of the dashboard. This will obviously have limitations, and could change in the future. More documentation on creating Grafana dashboards via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#dashboards).

#### Properties

Property         |   Type    | Default Value | Description
---------------- | :-------: | :-----------: | ------------------------------------------------------------------------------------------------------------------------
`host`           | `String`  | `'localhost'` | The host grafana is running on
`port`           | `Integer` |    `3000`     | The port grafana is running on
`admin_user`     | `String`  |   `'admin'`   | A grafana user with admin privileges
`admin_password` | `String`  |   `'admin'`   | The grafana user's password
`dashboard`      | `String`  |               | A Hash of the values to create the dashboard. Examples below.
`action`         | `String`  |   `create`    | Valid actions are `create`, `update`, and `delete`. Create can update the dashbord, be careful (see below for details) !

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

#### Properties

Property         |   Type    |    Default Value    | Description
---------------- | :-------: | :-----------------: | ----------------------------------------------------------------
`host`           | `String`  |    `'localhost'`    | The host grafana is running on
`port`           | `Integer` |       `3000`        | The port grafana is running on
`admin_user`     | `String`  |      `'admin'`      | A grafana user with admin privileges
`admin_password` | `String`  |      `'admin'`      | The grafana user's password
`organization    |  `Hash`   |        `{}`         | A Hash of the values to create the organization. Examples below.
`action`         | `String`  | `create_if_missing` | Valid actions are `create`, `update` and `delete`.

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

#### Properties

Property         |   Type    | Default Value | Description
---------------- | :-------: | :-----------: | --------------------------------------------------------
`host`           | `String`  | `'localhost'` | The host grafana is running on
`port`           | `Integer` |    `3000`     | The port grafana is running on
`admin_user`     | `String`  |   `'admin'`   | A grafana user with admin privileges
`admin_password` | `String`  |   `'admin'`   | The grafana user's password
`user`           |  `Hash`   |     `{}`      | A Hash of the values to create the user. Examples below.
`action`         | `String`  |   `create`    | Valid actions are `create`, `update`, `delete`.

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

#### Properties

Property          |   Type   |       Default Value       | Description
----------------- | :------: | :-----------------------: | ------------------------------------------------
`name`            | `String` |           `''`            | Name of the plugin.
`action`          | `String` |         `install`         | Valid actions are `install`, `update`, `remove`.
`grafana_cli_bin` | `String` | `'/usr/sbin/grafana-cli'` | The path to the grafana-cli binary

#### Examples

```ruby
grafana_plugin grafana-clock-panel do
  action :install
  grafana_cli_bin '/usr/sbin/grafana-cli'
end
```

## License and Authors
Based on `chef-kibana` cookbook by:

- John E. Vincent [lusis.org+github.com@gmail.com](mailto:lusis.org+github.com@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. jhenry82
