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

- `node['grafana']['install_type']` - The type of install we are going to use either `git` or `zipfile`
- `node['grafana']['git']['url']` - The url for the git repo to use for Grafana
- `node['grafana']['git']['branch']` - The sha or branch name to use
- `node['grafana']['file']['type']` - the type of archive file.  `zip` only at this stage
- `node['grafana']['file']['url']` - The zipfile URL for the latest Grafana build
- `node['grafana']['file']['checksum']` - The sha256 of the Grafana zipfile
- `node['grafana']['install_path']` - The root directory where Grafana will be installed
- `node['grafana']['install_dir']` - The directory to checkout into. A `current` symlink will be created in this directory as well.
- `node['grafana']['es_server']` - The ipaddress or hostname of your elasticsearch server
- `node['grafana']['es_port']` - The port of your elasticsearch server's http interface
- `node['grafana']['es_role']` - eventually for wiring up discovery of your elasticsearch server
- `node['grafana']['es_scheme']` - Scheme helper if elasticsearch is outside of this cookbook `http://` or `https://`
- `node['grafana']['graphite_server']` - The ipaddress or hostname of your graphite server
- `node['grafana']['graphite_port']` - The port of your graphite server's http interface
- `node['grafana']['graphite_role']` - eventually for wiring up discovery of your graphite server
- `node['grafana']['graphite_scheme']` - Scheme helper if graphite is outside of this cookbook `http://` or `https://`
- `node['grafana']['user']` - The user who will own the files from the git checkout. (default: the web server user)
- `node['grafana']['config_template']` - The template to use for Grafana's `config.js`
- `node['grafana']['config_cookbook']` - The cookbook that contains said config template
- `node['grafana']['webserver']` - Which webserver to use: apache, nginx or ''
- `node['grafana']['webserver_hostname']` - The primary vhost the web server will use for Grafana
- `node['grafana']['webserver_aliases']` - Array of any secondary hostnames that are valid vhosts
- `node['grafana']['webserver_listen']` - The ip address the web server will listen on
- `node['grafana']['webserver_port']` - The port the webserver will listen on
- `node['grafana']['webserver_scheme']` - Scheme helper if webserver is outside of this cookbook `http://` or `https://`

#### kibana::nginx

- `node['grafana']['nginx']['template']` - The template file to use for the nginx site configuration
- `node['grafana']['nginx']['template_cookbook']` - The cookbook containing said template

Removed:

- `node['grafana']['nginx']['enable_default_site']` - use `node['nginx']['enable_default_site']`

Usage
-----
#### grafana::default
The default recipe will:

- install Grafana from `master` into `/opt/grafana/master` and create a symlink called `current` in the same directory to `master`
- install `nginx` and serve the grafana application

If you want to use the zipfile distribution of Grafana update `node['grafana']['install_type']` attribute to `zipfile`.  Set `node['grafana']['zipfile_checksum']` to appropriate sha256 value of latest zipfile.

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
