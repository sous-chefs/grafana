[![Build Status](https://travis-ci.org/JonathanTron/chef-grafana.svg?branch=master)](https://travis-ci.org/JonathanTron/chef-grafana)

grafana Cookbook
===============

A stand-alone cookbook for Grafana

Requirements
------------
- apt
- nginx
- git

Attributes
----------
As with most cookbooks I write, this one is hopefully flexible enough to be wrapped by allowing you to override as much as possible

#### grafana::default

| Attribute                                    | Default                                | Description                       |
|----------------------------------------------|:--------------------------------------:|-----------------------------------|
| `node['grafana']['install_type']`            | `'file'`                               | The type of install we are going to use either `git` or `file` |
| `node['grafana']['git']['url']`              | `'https://github.com/grafana/grafana'` | The url for the git repo to use for Grafana |
| `node['grafana']['git']['branch']`           | `'master'`                             | The sha or branch name to use |
| `node['grafana']['file']['type']`            | `'tar.gz'`                             | the type of archive file. `zip` or `tar.gz`. |
| `node['grafana']['file']['url']`             | `'http://grafanarel.s3.amazonaws.com/grafana-1.7.0.tar.gz'` | The file URL for the latest Grafana build |
| `node['grafana']['file']['checksum']`        | `'6da4c234677ffe7ebb1268fa46a9c03921478c789eb600774575b1629793ef57'`| The sha256 of the Grafana file |
| `node['grafana']['install_path']`            | `'/srv/apps'`                          | The root directory where Grafana will be installed |
| `node['grafana']['install_dir']`             | `'/srv/apps/grafana'`                  | The directory to checkout into. A `current` symlink will be created in this directory as well. |
| `node['grafana']['es_server']`               | `'127.0.0.1'`                          | The ipaddress or hostname of your elasticsearch server |
| `node['grafana']['es_port']`                 | `'9200'`                               | The port of your elasticsearch server's http interface |
| `node['grafana']['es_role']`                 | `'elasticsearch_server'`               | eventually for wiring up discovery of your elasticsearch server |
| `node['grafana']['es_scheme']`               | `'http://'`                            | Scheme helper if elasticsearch is outside of this cookbook `http://` or `https://` |
| `node['grafana']['es_user']`                 | `''`                                   | Elasticsearch authentication user |
| `node['grafana']['es_password']`             | `''`                                   | Elasticsearch authentication password |
| `node['grafana']['graphite_server']`         | `'127.0.0.1'`                          | The ipaddress or hostname of your graphite server |
| `node['grafana']['graphite_port']`           | `'80'`                                 | The port of your graphite server's http interface |
| `node['grafana']['graphite_role']`           | `'graphite_server'`                    | eventually for wiring up discovery of your graphite server |
| `node['grafana']['graphite_scheme']`         | `'http://'`                            | Scheme helper if graphite is outside of this cookbook `http://` or `https://` |
| `node['grafana']['graphite_user']`           | `''`                                   | Graphite authentication user |
| `node['grafana']['graphite_password']`       | `''`                                   | Graphite authentication password |
| `node['grafana']['user']`                    | `''`                                   | The user who will own the files from the git checkout. |
| `node['grafana']['config_template']`         | `'config.js.erb'`                      | The template to use for Grafana's `config.js` |
| `node['grafana']['config_cookbook']`         | `'grafana'`                            | The cookbook that contains said config template |
| `node['grafana']['webserver']`               | `'nginx'`                              | Which webserver to use: nginx or '' |
| `node['grafana']['webserver_hostname']`      | `node.name`                            | The primary vhost the web server will use for Grafana |
| `node['grafana']['webserver_aliases']`       | `[node['ipaddress']]`                  | Array of any secondary hostnames that are valid vhosts |
| `node['grafana']['webserver_listen']`        | `node['ipaddress']`                    | The ip address the web server will listen on |
| `node['grafana']['webserver_port']`          | `80`                                   | The port the webserver will listen on |
| `node['grafana']['webserver_scheme']`        | `'http://'`                            | Scheme helper if webserver is outside of this cookbook `http://` or `https://` |
| `node['grafana']['timezone_offset']`         | `'null'`                               | Timezone offset config, example: "-0500" (for UTC-5 hours) |
| `node['grafana']['grafana_index']`           | `'grafana-index'`                      | Elasticsearch index to use for Grafana |
| `node['grafana']['unsaved_changes_warning']` | `'true'`                               | Enable disable unsaved changes warning in UI |
| `node['grafana']['playlist_timespan']`       | `'1m'`                                 | Playlist timespan config |
| `node['grafana']['datasources']`             | see below                              | Grafana (`> 1.7.0`) data sources configuration |

Starting with `1.7.0`, Grafana uses `datasources` array in its configuration file
to know about the multiple databases it should read data from (`elasticsearch`,
`graphite`, `InfluxDB`, ...), we're generating this array from
`node['grafana']['datasources']`, the defaults are:

```ruby
{
  'graphite' => {
    'type' => "'graphite'",
    'url'  => 'window.location.protocol+"//"+window.location.hostname+":"+window.location.port+"/_graphite"',
    'default' => true
  },
  'elasticsearch' => {
    'type' => "'elasticsearch'",
    'url'  => 'window.location.protocol+"//"+window.location.hostname+":"+window.location.port',
    'index' => "'#{node['grafana']['grafana_index']}'",
    'grafanaDB' => true
  }
}
```

#### kibana::nginx

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

- install Grafana from `master` into `/opt/grafana/master` and create a symlink called `current` in the same directory to `master`
- install `nginx` and serve the grafana application

If you want to use the file distribution of Grafana update `node['grafana']['install_type']` attribute to `file`.  Set `node['grafana']['checksum']` to appropriate sha256 value of latest archive file.

If you don't want this cookbook to handle the webserver config simply set `node['grafana']['webserver']` to `''` in a role/environment/node somewhere.
Please note that in this case you have to set `node['grafana']['user']`.

Nginx recipe, by default, will configure the appropriate proxy to your ElasticSearch server such that you don't have to expose it to the world.

**NOTE**
There is **NO** security enabled by default on any of the content being served.
If you would like to modify the `nginx` parameters, you should:

- create your own cookbook i.e. `my-grafana`
- copy the template for the webserver you wish to use to your cookbook
- modify the template as you see fit (add auth, setup ssl)
- use the appropriate webserver template attributes to point to your cookbook and template

Testing
-------
#### kitchen-test

Requires Vagrant >= 1.2 with the following plugins :

* vagrant-berkshef
* vagrant-omnibus

```
$ bundle install
$ kitchen test
```

Contributing
------------
- Fork the repository on Github
- Create a named feature branch (like `add_component_x`)
- Write you change
- Write tests for your change (if applicable)
- Run the tests, ensuring they all pass
-- `bundle exec strainer test`
- Submit a Pull Request using Github

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
