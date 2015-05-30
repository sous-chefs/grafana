## This is a pre-release, work-in-progress version of the grafana cookbook for Grafana 2.0. We are working toward the [chef-grafana 2.0 milestone](https://github.com/JonathanTron/chef-grafana/milestones/chef-grafana%202.0). Please feel free to contribute, but note that this is very much a work in progress.

There are attributes and recipes that will be deprecated and new features that will certainly be added. Please be patient as the work proceeds. Thanks!

Grafana Cookbook [![Build Status](https://travis-ci.org/JonathanTron/chef-grafana.svg?branch=master)](https://travis-ci.org/JonathanTron/chef-grafana)
===============

A stand-alone cookbook for Grafana. The 2.x versions of this cookbook work with the 2.x versions of Grafana. There is no backward compatibility for pre-2.0 versions of Grafana in the 2.x versions of this cookbook.

Requirements
------------
- apt
- yum
- nginx

Attributes
----------
As with most cookbooks I write, this one is hopefully flexible enough to be wrapped by allowing you to override as much as possible

#### grafana::default

| Attribute                                    | Default                                | Description                       |
|----------------------------------------------|:--------------------------------------:|-----------------------------------|
| `node['grafana']['install_type']`            | `'file'`                               | The type of install we are going to use either `git` or `file` |
| `node['grafana']['version']`                 | `'2.0.2'`                              | the version to install. |
| `node['grafana']['file']['url']`             | `'http://grafanarel.s3.amazonaws.com/grafana-1.9.1.tar.gz'` | The file URL for the latest Grafana build |
| `node['grafana']['file']['checksum']`        | `'c328c7a002622f672affbcaabd5e64ae279be1051ee27c62ba22bfed63680508'`| The sha256 of the Grafana file |
| `node['grafana']['admin_password']`          | `'admin'`                              | This is a password used when saving dashboard |
| `node['grafana']['graphite_server']`         | `'127.0.0.1'`                          | The ipaddress or hostname of your graphite server |
| `node['grafana']['graphite_port']`           | `'80'`                                 | The port of your graphite server's http interface |
| `node['grafana']['graphite_role']`           | `'graphite_server'`                    | eventually for wiring up discovery of your graphite server, set to `nil` to prevent any search |
| `node['grafana']['graphite_scheme']`         | `'http://'`                            | Scheme helper if graphite is outside of this cookbook `http://` or `https://` |
| `node['grafana']['graphite_user']`           | `''`                                   | Graphite authentication user |
| `node['grafana']['graphite_password']`       | `''`                                   | Graphite authentication password |
| `node['grafana']['user']`                    | `''`                                   | The user who will own the files from the git checkout. |
| `node['grafana']['config_template']`         | `'config.js.erb'`                      | The template to use for Grafana's `config.js` |
| `node['grafana']['webserver']`               | `'nginx'`                              | Which webserver to use: nginx or '' |
| `node['grafana']['webserver_hostname']`      | `node.name`                            | The primary vhost the web server will use for Grafana |
| `node['grafana']['webserver_aliases']`       | `[node['ipaddress']]`                  | Array of any secondary hostnames that are valid vhosts |
| `node['grafana']['webserver_listen']`        | `node['ipaddress']`                    | The ip address the web server will listen on |
| `node['grafana']['webserver_port']`          | `80`                                   | The port the webserver will listen on |
| `node['grafana']['webserver_scheme']`        | `'http://'`                            | Scheme helper if webserver is outside of this cookbook `http://` or `https://` |
| `node['grafana']['default_route']`           | `'/dashboard/file/default.json'`       | Default route config, set start dashboard |
| `node['grafana']['timezone_offset']`         | `'null'`                               | Timezone offset config, example: "-0500" (for UTC-5 hours) |
| `node['grafana']['grafana_index']`           | `'grafana-index'`                      | Elasticsearch index to use for Grafana |
| `node['grafana']['unsaved_changes_warning']` | `'true'`                               | Enable disable unsaved changes warning in UI |
| `node['grafana']['playlist_timespan']`       | `'1m'`                                 | Playlist timespan config |
| `node['grafana']['window_title_prefix']`     | `'Grafana - '`                         | Window title prefix config |
| `node['grafana']['search_max_results']`      | `20`                                   | Search maximuyum result config  |


**NOTE**
Any derived attributes should be wrapped in a lambda if you expect to change
the value of the root attribute (see example above).

#### grafana::nginx

| Attribute                                       | Default                    | Description                       |
|-------------------------------------------------|:--------------------------:|-----------------------------------|
| `node['grafana']['nginx']['template']`          | `'grafana-nginx.conf.erb'` | The template file to use for the nginx site configuration |
| `node['grafana']['nginx']['template_cookbook']` | `'grafana'`                | The cookbook containing said template |

Removed:

- `node['grafana']['nginx']['enable_default_site']` - use `node['nginx']['enable_default_site']`

Usage
-----
#### grafana::default
The default recipe will:

- install Grafana via downloaded system package
- install `nginx` to proxy the grafana application

If you want to install the Grafana package repository, update `node['grafana']['install_type']` attribute to `package`.  Set `node['grafana']['checksum']` to appropriate sha256 value of latest archive file.

Nginx is used to proxy Grafana to run on port 80 as well other proxying for Elaticsearch. If you don't want this cookbook to handle the webserver config simply set `node['grafana']['webserver']` to `''` in a role/environment/node somewhere.


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
You can control Grafana DataSources via the `grafana_datasource` LWRP. Due to the varying nature of the potental data sources, the information used to create the datasource is consumed by the resource as a Hash (the `source` attribute). The examples should be able to illustrate the flexibility.

#### Attributes
| Attribute      | Type     | Default Value     | Description                       |
|----------------|:--------:|:-----------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`     | The host grafana is running on    |
| `port`         | `String` | `'3000'`          | The port grafana is running on    |
| `user`         | `String` | `'admin'`         | A grafana user with admin privileges |
| `password`     | `String` | `'admin'`         | The grafana user's password    |
| `source_name`  | `String` |                   | The Data Source name as it will appear in Grafana. Defaults to the name unsed in the resource invocation. |
| `source`       | `Hash  ` | `{}`              | A Hash of the values to create the datasource. Examples below. |
| `action`       | `String` | `create`          | Valid actions are `create`, `create_if_missing`, and `delete`. Create will update the datasource if it already exists. |


#### Example
You can create a data source for InfluxDB 0.8.x as follows:

```ruby
grafana_datasource 'influxdb-test' do
  source(
    type: 'influxdb_08',
    url: 'http://10.0.0.10:8086',
    access: 'direct',
    database: 'metrics',
    user: 'dashboard',
    password: 'dashpass'
  )
  action :create_if_missing
end
```

### grafana_dashboard
Dashboards in Grafana are always going to be incredibly specific to the application, but you may want to be able to create a new dashboard along with a newly provisioned stack. This resource assumes you have a static json file that displays the information that will be flowing from the newly created stack.

This resource currently makes an assumption that the name used in invocation matches the name of the dashboard. This will obviously have limitations, and can change in the future.

#### Attributes
| Attribute      | Type     | Default Value       | Description                       |
|----------------|:--------:|:-------------------:|-----------------------------------|
| `host`         | `String` | `'localhost'`       | The host grafana is running on    |
| `port`         | `String` | `'3000'`            | The port grafana is running on    |
| `user`         | `String` | `'admin'`           | A grafana user with admin privileges |
| `password`     | `String` | `'admin'`           | The grafana user's password       |
| `source_name`  | `String` |                     | The extensionless name of the dashboard json file, and should match the dashboard title in the json (lower-cased and with hyphens for spaces) if `source` is not provided. Defaults to the name used in the resource invocation. |
| `source`       | `String` | `nil`               | If you would like to override the name of the json file, use this attribute. |
| `overwrite`    | `boolean`| `true`              | Whether you want to overwrite existing dashboard with newer version or with same dashboard title |
| `action`       | `String` | `create_if_missing` | Valid actions are `create`, `create_if_missing`, and `delete`. Create will update the dashboard, so be careful! |

#### Example
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

TODO
----
- Finish implementation of the dashboard resource
- Implement user resource via the API
- Continue to template out the `grafana.ini.erb` and `grafana-env.erb` templates
- Test with Graphie datasource
- Remove Elasticsearch references
- Complete the `source` recipe
- Allow SSL to be enabled on Nginx
- Implement organization reource via the API

License and Authors
-------------------
Primary author:

- Jonathan Tron <jonathan@tron.name>

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
- Michael Lanyon (@lanyonm)

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
