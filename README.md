# Grafana Cookbook

[![Build Status](https://secure.travis-ci.org/sous-chefs/chef-grafana.png?branch=master)](http://travis-ci.org/sous-chefs/grafana) [![Cookbook Version](https://img.shields.io/cookbook/v/grafana.svg)](https://supermarket.chef.io/cookbooks/grafana)

## Overview

A stand-alone cookbook for Grafana. The 2.x versions of this cookbook work with the 2.x versions of Grafana. There is no backward compatibility for pre-2.0 versions of Grafana in the 2.x versions of this cookbook.

If you would like to configure pre-2.0 versions of Grafana, please use the 1.x branch and 1.x versions of this cookbook in the supermarket. There is a 1.x tag for PRs or Issues related to the 1.x branch.

## Requirements

### Chef Client

- Chef Client 13+

### Platforms

- Ubuntu >= 14.04
- Debian >= 8
- CentOS/Redhat >= 6

### Cookbooks

- [nginx](https://supermarket.chef.io/cookbooks/nginx) 7+

## Recipes

- `default` - Wrap private recipes for Grafana setup

## Attributes

As with most cookbooks, this one is hopefully flexible enough to be wrapped by allowing you to override as much as possible. Please let us know if you find a value that is not configurable.

### grafana::default

Attribute                                    |                               Default                                | Description
-------------------------------------------- | :------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------
`node['grafana']['manage_install']`          |                                `true`                                | Whether or not the installation should be managed by this cookbook.
`node['grafana']['install_type']`            |                               `'file'`                               | The type of install: `file`, `package` or `source`. _Note_: `source` is not currently supported.
`node['grafana']['version']`                 |                              `'2.1.2'`                               | The version to install. For the most recent versions use `'latest'`.
`node['grafana']['file']['url']`             |        `'https://grafanarel.s3.amazonaws.com/builds/grafana'`        | The file URL for Grafana builds
`node['grafana']['file']['checksum']['deb']` | `'57f52cc8e510f395f7f15caac841dc31e67527072fcbf5cc2d8351404989b298'` | The SHA256 checksum of Grafana .deb file
`node['grafana']['file']['checksum']['rpm']` | `'618f5361e594b101a4832a67a9d82f1179c35ff158ef4288dc1f8b6e8de67bb8'` | The SHA256 checksum of Grafana .rpm file
`node['grafana']['package']['repo']`         |             `'https://packagecloud.io/grafana/stable/'`              | The grafana package repo
`node['grafana']['package']['key']`          |                 `'https://packagecloud.io/gpg.key'`                  | The package repo GPG key
`node['grafana']['package']['components']`   |                              `['main']`                              | The package repo components
`node['grafana']['user']`                    |                             `'grafana'`                              | The grafana user
`node['grafana']['group']`                   |                             `'grafana'`                              | The grafana group
`node['grafana']['home']`                    |                        `'/usr/share/grafana'`                        | The value set to GRAFANA_HOME
`node['grafana']['data_dir']`                |                         `'/var/lib/grafana'`                         | The path grafana can use to store temp files, sessions, and the sqlite3 db
`node['grafana']['log_dir']`                 |                         `'/var/log/grafana'`                         | Grafana's log directory
`node['grafana']['plugins_dir']`             |                     `'/var/lib/grafana/plugins'`                     | Grafana's plugins directory
`node['grafana']['env_dir']`                 |                `'/etc/default'` or `'/etc/sysconfig'`                | The location for environment variables - autoconfigured for rhel and debian systems
`node['grafana']['conf_dir']`                |                           `'/etc/grafana'`                           | The location to store the `grafana.ini` file
`node['grafana']['restart_on_upgrade']`      |                               `false`                                | Whether or not to restart the service on upgrade when installing from packages
`node['grafana']['webserver']`               |                              `'nginx'`                               | Which webserver to use: `'nginx'` or `''`
`node['grafana']['webserver_hostname']`      |                             `node.name`                              | The server_name used in the webserver config
`node['grafana']['webserver_aliases']`       |                        `[node['ipaddress']]`                         | Array of any secondary hostnames that are valid vhosts
`node['grafana']['webserver_listen']`        |                         `node['ipaddress']`                          | The ip address the web server will listen on
`node['grafana']['webserver_port']`          |                                 `80`                                 | The port the webserver will listen on
`node['grafana']['cli_bin']`                 |                       `/usr/sbin/grafana-cli`                        | The path to the grafana-cli binary
`node['grafana']['plugins']`                 |                               `empty`                                | Array of plugins to install

#### grafana.ini

For the ini configuration file, parameters can be specified as this: `node['grafana']['ini'][SECTION_NAME][KEY] = [VALUE]`. Here's an example:

```ruby
default['grafana']['ini']['server']['protocol'] = 'http'
```

It is also possible to specify a comment that will precede the parameter and to comment the parameter as well.

```ruby
default['grafana']['ini']['database']['ssl_mode'] = {
  comment: 'For "postgres" only, either "disable", "require" or "verify-full"',
  disable: true,
  value: 'disable'
}
```

See attributes/default.rb file for more details and examples.

#### grafana::nginx

Attribute                                       |           Default           | Description
----------------------------------------------- | :-------------------------: | ----------------------------------------------------------------
`node['grafana']['nginx']['template']`          | `'grafana-nginx.conf.erb'`  | The template file to use for the nginx site configuration
`node['grafana']['nginx']['template_cookbook']` |         `'grafana'`         | The cookbook containing said template
`node['grafana']['nginx']['basic_auth']`        |           `false`           | If `true` generated nginx config will have basic auth configured
`node['grafana']['nginx']['httpasswd_file']`    | `/etc/nginx/htpasswd.users` | The basic auth user/password file to use

**NOTE**

This cookbook does nothing to generate the basic auth user/password file, you will have to make sure this file is created and is valid.

## Usage

### grafana::default

The default recipe will:

- install Grafana via downloaded system package
- install `nginx` to proxy the grafana application

If you want to install the Grafana package repository, update `node['grafana']['install_type']` attribute to `package`. Additionally, the `node['grafana']['version']` can be set to `'latest'` so that the very latest Grafana build is used instead of the default release.

Nginx is used to proxy Grafana to run on port 80\. If you don't want this cookbook to handle the webserver config simply set `node['grafana']['webserver']` to `''` in a role/environment/node somewhere.

**NOTE** There is **NO** security enabled by default on any of the content being served. If you would like to modify the `nginx` parameters, you should:

- create your own cookbook i.e. `my-grafana`
- copy the template for the webserver you wish to use to your cookbook
- modify the template as you see fit (add auth, setup ssl)
- use the appropriate webserver template attributes to point to your cookbook and template

### grafana::plugins

This recipe will install the plugins given with the `node['grafana']['plugins']` attribute

It will use the grafana_plugin LWRP described in the section below.

## Resources

It's important to note that Grafana must be running for these resources to be used because they utilize Grafana's HTTP API. In your recipe, you'll simply need to make sure that you include the default recipe that starts Grafana before using these.

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

## Testing

### Foodcritic & Rubocop

```
$ bundle exec foodcritic -X spec -f any ./
$ bundle exec rubocop
```

### ChefSpec

```
$ bundle exec rspec
```

### kitchen-test

Requires Vagrant >= 1.7.

```
$ bundle install
$ bundle exec kitchen test
```

## License and Authors

Primary authors:

- Jonathan Tron [jonathan@tron.name](mailto:jonathan@tron.name)
- Mike Lanyon [lanyonm@gmail.com](mailto:lanyonm@gmail.com)

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
- Andrei Skopenko (@scopenco)

Based on `chef-kibana` cookbook by:

- John E. Vincent [lusis.org+github.com@gmail.com](mailto:lusis.org+github.com@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. jhenry82
