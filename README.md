Grafana Cookbook [![Build Status](https://travis-ci.org/JonathanTron/chef-grafana.svg?branch=master)](https://travis-ci.org/JonathanTron/chef-grafana)
================

A stand-alone cookbook for Grafana. The 2.x versions of this cookbook work with the 2.x versions of Grafana. There is no backward compatibility for pre-2.0 versions of Grafana in the 2.x versions of this cookbook.

If you would like to configure pre-2.0 versions of Grafana, please use the 1.x branch and 1.x versions of this cookbook in the supermarket. There is a 1.x tag for PRs or Issues related to the 1.x branch.

Requirements
------------
- apt
- yum
- nginx

Attributes
----------
As with most cookbooks, this one is hopefully flexible enough to be wrapped by allowing you to override as much as possible. Please let us know if you find a value that is not configurable.

#### grafana::default

| Attribute                                    | Default                                | Description                       |
|----------------------------------------------|:--------------------------------------:|-----------------------------------|
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
| `node['grafana']['env_dir']`                 | `'/etc/default'` or `'/etc/sysconfig'` | The location for environment variables - autoconfigured for rhel and debian systems |
| `node['grafana']['conf_dir']`                | `'/etc/grafana'`                       | The location to store the `grafana.ini` file |
| `node['grafana']['webserver']`               | `'nginx'`                              | Which webserver to use: `'nginx'` or `''` |
| `node['grafana']['webserver_hostname']`      | `node.name`                            | The server_name used in the webserver config |
| `node['grafana']['webserver_aliases']`       | `[node['ipaddress']]`                  | Array of any secondary hostnames that are valid vhosts |
| `node['grafana']['webserver_listen']`        | `node['ipaddress']`                    | The ip address the web server will listen on |
| `node['grafana']['webserver_port']`          | `80`                                   | The port the webserver will listen on |

##### grafana.ini
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

| Attribute                                       | Default                    | Description                       |
|-------------------------------------------------|:--------------------------:|-----------------------------------|
| `node['grafana']['nginx']['template']`          | `'grafana-nginx.conf.erb'` | The template file to use for the nginx site configuration |
| `node['grafana']['nginx']['template_cookbook']` | `'grafana'`                | The cookbook containing said template |

Usage
-----
#### grafana::default
The default recipe will:

- install Grafana via downloaded system package
- install `nginx` to proxy the grafana application

If you want to install the Grafana package repository, update `node['grafana']['install_type']` attribute to `package`. Additionally, the `node['grafana']['version']` can be set to `'latest'` so that the very latest Grafana build is used instead of the default release.

Nginx is used to proxy Grafana to run on port 80. If you don't want this cookbook to handle the webserver config simply set `node['grafana']['webserver']` to `''` in a role/environment/node somewhere.


**NOTE**
There is **NO** security enabled by default on any of the content being served.
If you would like to modify the `nginx` parameters, you should:

- create your own cookbook i.e. `my-grafana`
- copy the template for the webserver you wish to use to your cookbook
- modify the template as you see fit (add auth, setup ssl)
- use the appropriate webserver template attributes to point to your cookbook and template

Resources
---------
It's important to note that Grafana must be running for these resources to be used because they utilitze Grafana's HTTP API. In your recipe, you'll simply need to make sure that you include the default recipe that starts Grafana before using these.

### grafana_datasource
You can control Grafana dataSources via the `grafana_datasource` LWRP. Due to the varying nature of the potental data sources, the information used to create the datasource is consumed by the resource as a Hash (the `source` attribute). The examples should illustrate the flexibility. The full breadth of options are (or will be) documented on the [Grafana website](http://docs.grafana.org/reference/http_api/#data-sources), however you can discover undocumented parameters by inspecting the HTTP requests your browser makes to the Grafana server.

#### Attributes
| Attribute      | Type     | Default Value     | Description                       |
|----------------|:--------:|:-----------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`     | The host grafana is running on    |
| `port`         | `Integer`| `3000`            | The port grafana is running on    |
| `user`         | `String` | `'admin'`         | A grafana user with admin privileges |
| `password`     | `String` | `'admin'`         | The grafana user's password    |
| `source_name`  | `String` |                   | The Data Source name as it will appear in Grafana. Defaults to the name unsed in the resource invocation. |
| `source`       | `Hash  ` | `{}`              | A Hash of the values to create the datasource. Examples below. |
| `action`       | `String` | `create`          | Valid actions are `create`, `create_if_missing`, and `delete`. Create will update the datasource if it already exists. |


#### Examples
You can create a data source for Graphite as follows:

```ruby
grafana_datasource 'graphite-test' do
  source(
    type: 'graphite',
    url: 'http://10.0.0.15:8080',
    access: 'direct'
  )
end
```

You can create a data source for InfluxDB 0.8.x and make it the default dashboard as follows:

```ruby
grafana_datasource 'influxdb-test' do
  source(
    type: 'influxdb_08',
    url: 'http://10.0.0.10:8086',
    access: 'proxy',
    database: 'metrics',
    user: 'dashboard',
    password: 'dashpass',
    isdefault: true
  )
  action :create_if_missing
end
```

### grafana_dashboard
Dashboards in Grafana are always going to be incredibly specific to the application, but you may want to be able to create a new dashboard along with a newly provisioned stack. This resource assumes you have a static json file that displays the information that will be flowing from the newly created stack.

This resource currently makes an assumption that the name used in invocation matches the name of the dashboard. This will obviously have limitations, and could change in the future. More documentation on creating Grafana dashboards via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#dashboards).

#### Attributes
| Attribute      | Type     | Default Value       | Description                       |
|----------------|:--------:|:-------------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`       | The host grafana is running on    |
| `port`         | `Integer`| `3000`              | The port grafana is running on    |
| `user`         | `String` | `'admin'`           | A grafana user with admin privileges |
| `password`     | `String` | `'admin'`           | The grafana user's password       |
| `source_name`  | `String` |                     | The extensionless name of the dashboard json file, and should match the dashboard title in the json (lower-cased and with hyphens for spaces) if `source` is not provided. Defaults to the name used in the resource invocation. |
| `source`       | `String` | `nil`               | If you would like to override the name of the json file, use this attribute. |
| `cookbook`     | `String` | `nil`               | The cookbook name to pull the file from if not this one |
| `path`         | `String` | `nil`               | _Overrides `cookbook` and `source`_. The absolute path to the json file on disk. |
| `overwrite`    | `boolean`| `true`              | Whether you want to overwrite existing dashboard with newer version or with same dashboard title |
| `action`       | `String` | `create_if_missing` | Valid actions are `create`, `create_if_missing`, and `delete`. Create will update the dashboard, so be careful! |

#### Examples
Assuming you have a `files/default/simple-dashboard.json`:

```ruby
grafana_dashboard 'simple-dashboard'
```

If you'd like to use a `my-dashboard.json` with the title `"title": "Test Dash"`:

```ruby
grafana_dashboard 'test-dash' do
  source 'my-dashboard'
  overwrite false
end
```

If the dashboard you would like to import is already on disk with the title `"title": "On Disk Dash"`:

```ruby
grafana_dashboard 'on-disk-dash' do
  path '/opt/grafana/dashboards/local-dash.json'
end
```

### grafana_organization
This resource will allow you to create organizations within Grafana. This resource is minimally viable and only supports the addition of a new organization by name. It does check to see if an organization of the same name already exists, but it does not currently support adding address or city information.

More information about creating Grafana organizations via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#organizations).

#### Attributes
| Attribute      | Type     | Default Value       | Description                       |
|----------------|:--------:|:-------------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`       | The host grafana is running on    |
| `port`         | `Integer`| `3000`              | The port grafana is running on    |
| `user`         | `String` | `'admin'`           | A grafana user with admin privileges |
| `password`     | `String` | `'admin'`           | The grafana user's password       |
| `name`         | `String` |                     | The name of the organization you would like to add. Defaults to the name used in the resource invocation. |
| `action`       | `String` | `create_if_missing` | Valid actions are `create_if_missing`. Delete and create are not currently supported. |

#### Examples
Assuming you would like to create a new organization called `Second Org.`:

```ruby
grafana_organization 'Second Org.'
```

### grafana_user
This resource will allow you to create global users within Grafana. This resource is minimally viable and only supports the addition of global non-admin users. Contribution to the funcationality would be appreciated.

More information about creating Grafana users via the HTTP API can be found [here](http://docs.grafana.org/reference/http_api/#users).

#### Attributes
| Attribute      | Type     | Default Value       | Description                       |
|----------------|:--------:|:-------------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`       | The host grafana is running on    |
| `port`         | `Integer`| `3000`              | The port grafana is running on    |
| `user`         | `String` | `'admin'`           | A grafana user with admin privileges |
| `password`     | `String` | `'admin'`           | The grafana user's password       |
| `global`       | `boolean`| `true`              | Whether you want the user to be a global user. _Currently only global `true` is supported._ |
| `admin`        | `boolean`| `false`             | Whether or not the user should be a global admin. _Currently only admin `false` is supported._ |
| `login`        | `String` |                     | The login for this user. Defaults to the name used in the resource invocation. |
| `full_name`    | `String` |                     | The common, human-readable name used for the user |
| `email`        | `String` |                     | The email address for this user   |
| `passwd`       | `String` |                     | The password to use for this user |
| `action`       | `String` | `create_if_missing` | Valid actions are `create_if_missing`. Delete and create are not currently supported. |

#### Examples
Assuming you would like to create a new user...

```ruby
grafana_user 'person2' do
  full_name 'John Smith'
  email 'test@example.com'
  passwd 'test123'
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
