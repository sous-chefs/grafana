# CHANGELOG for grafana

This file is used to list changes made in each version of grafana.

## 2.1.3 (2015-08-24):

* Fix a bug in error message handling code [#80](https://github.com/JonathanTron/chef-grafana/issues/80)

## 2.1.2 (2015-08-24):

* Fix Grafana package checksums [#79](https://github.com/JonathanTron/chef-grafana/issues/79)

## 2.1.1 (2015-08-20):

* Update Grafana default version to 2.1.2
* Ensure we're displaying better messages in some edge cases with HTTP requests [#76](https://github.com/JonathanTron/chef-grafana/issues/76)

## 2.1.0 (2015-08-17):

* Update Grafana default version to 2.1.1
* Make sure upgrading via deb file don't fail on configuration conflict [#74](https://github.com/JonathanTron/chef-grafana/issues/74)
* Ensure installing a new version trigger a server restart
* Add packages checksum to ensure expected file and prevent unecessary re-download (see warnings section below)
* Installation package file only if present and/or modified (@arifcse019) [#73](https://github.com/JonathanTron/chef-grafana/pull/73)
* Fix start service making it just be restarted at the end of the configuration (@HelioCampos) [#71](https://github.com/JonathanTron/chef-grafana/pull/71)
* Improve error messages during dashboard creation [#64](https://github.com/JonathanTron/chef-grafana/pull/64)
* Update ServerSpec test to check `:stderr` for curl output

__warning__

When using the default's file installation, we've added checksum for package files
if you set the grafana version to something different than the default you will
also need set the checksum for the package you're expecting to use:

```ruby
# Example if your Grafana version is different from the cookbook default
node['grafana']['version'] = '2.1.0'
# For debian platform family
node['grafana']['file']['checksum']['deb'] = 'b824c8358ff07f76f0d9eb35e9441f6f9e591819ad8bc70db4b0c904a8e7130e'
# For rhel platform family
node['grafana']['file']['checksum']['rpm'] = '1b436b286bd464e65eeb2a9b393da0986569fe483e1053b01c092b2e590d8399'
```

## 2.0.0 (2015-06-28):

* Major overhaul of the cookbook to support Grafana 2.x

## 1.x dev:

* Ensure setting `node['grafana']['listen_address']` to `nil` render a valid nginx config file (@lanyonm) [#39](https://github.com/JonathanTron/chef-grafana/pull/39)

## 1.5.5 (2015-03-29):

* Update `elasticsearch` git url in `Berksfile` for elasticsearch to elastic rename (@lanyonm) [#38](https://github.com/JonathanTron/chef-grafana/pull/38)
* Allow nginx to listen on all interface when `node['grafana']['webserver_listen']` is `nil` or `false` (@BackSlasher) [#37](https://github.com/JonathanTron/chef-grafana/pull/37)
* Fix base64 encoding appending a newline in nginx config for basic auth (@BackSlasher) [#36](https://github.com/JonathanTron/chef-grafana/pull/36)

## 1.5.4 (2015-02-22):

* Update `Grafana` to `1.9.1` (@osigida) [#32](https://github.com/JonathanTron/chef-grafana/pull/32)
* Interpolate "version" and "type" attributes to build grafana file url (Bernhard Köhler) [#31](https://github.com/JonathanTron/chef-grafana/pull/31) and (Olivier Bazoud)
  [#29](https://github.com/JonathanTron/chef-grafana/issues/29)
* Add support for lambdas in datasources. This change makes it possible to
  evaluate derived attributes correctly. (Bernhard Köhler) [#30](https://github.com/JonathanTron/chef-grafana/pull/30)
  and [#25](https://github.com/JonathanTron/chef-grafana/issues/25)

## 1.5.3 (2014-11-15):

* Add support for Centos[#28](https://github.com/JonathanTron/chef-grafana/issues/28)

## 1.5.2 (2014-11-04):

* Allow configuration of `default_route` via attributes (Miguel Landaeta) [#26](https://github.com/JonathanTron/chef-grafana/pull/26)
* Add support for grafana admin password option (Andrew Goktepe) [#23](https://github.com/JonathanTron/chef-grafana/pull/23)

## 1.5.1 (2014-10-08):

* Update `Grafana` to `1.8.1`

## 1.5.0 (2014-09-22):

* Update `Grafana` to `1.8.0`

__warning__

* Check for the presence of `node['grafana']['es_role']` and
  `node['grafana']['graphite_role']` instead of `node['grafana']['es_server']`
  and `node['grafana']['graphite_server']` to know if we should search and
  replace `default['grafana']['es_server']` and
  `default['grafana']['graphite_server']` (Jonathon W. Marshall) [#22](https://github.com/JonathanTron/chef-grafana/pull/22)


## 1.4.2 (2014-09-14):

* Fix attributes doc in README

## 1.4.1 (2014-09-12):

* Do not use `template` resource's `helpers` method to bring back older `Chef`
  compatibility.

## 1.4.0 (2014-09-12):

* Update `Grafana` to `1.8.0-rc1`
* Add `default['grafana']['window_title_prefix']` and
  `default['grafana']['search_max_results']` config attributes.

__warnings__

* `Grafana 1.8.0-rc1` upgraded to `JQuery` to `2.1.1` and thus dropped support for `Internet Explorer 7 and 8`

## 1.3.4 (2014-08-19):

* Update attributes in README for better Supermarket display
* Update `foodcritic` and `rubocop` (Tim Smith) [#21](https://github.com/JonathanTron/chef-grafana/pull/21)
* Remove mention of `zipfile` in README and attributes (Thanks to Gref Fitzgerald)
* Fix `default['grafana']['install_type']` documentation to have the correct
  possible values: `git` and `file` (Fred Hatfull) [#20](https://github.com/JonathanTron/chef-grafana/pull/20)
* Fix `default['grafana']['webserver']` documentation not to include `apache` as
  possible value. (osigida) [#19](https://github.com/JonathanTron/chef-grafana/pull/19)

## 1.3.2 (2014-08-12):

* Update default `Grafana` to `1.7.0`. (Greg Fitzgerald) [#18](https://github.com/JonathanTron/chef-grafana/pull/18).

## 1.3.1 (2014-08-07):

* Update `Grafana` to `1.7.1-rc1`. It fixes a regression introduced when merging
  [#16](https://github.com/JonathanTron/chef-grafana/pull/16). Thanks to
  Greg Fitzgerald for reporting it.

## 1.3.0 (2014-07-31):

* Allow attribute configuration for datasources (Grégoire Seux) [#16](https://github.com/JonathanTron/chef-grafana/pull/16)

## 1.2.0 (2014-07-11):

__breaking changes__

* Update `ark` dependency to `>= 0.7.2` and deprecation warning by using `strip_component` (Grégoire Seux) [#15](https://github.com/JonathanTron/chef-grafana/pull/14)

__minor changes__

* Support newer `nginx` cookbook by specifying `template: false` when enabling the `grafana` site (Grégoire Seux) [#15](https://github.com/JonathanTron/chef-grafana/pull/14)

## 1.1.1 (2014-07-10):

* Update default attributes to install Grafana 1.6.1 (Greg Fitzgerald) [#14](https://github.com/JonathanTron/chef-grafana/pull/14)

## 1.1.0 (2014-06-20):

__breaking changes__

* `config.js` data for `graphite` and `elasticsearch` changed back to use:

  - `window.location.protocol+"//"+window.location.hostname+":"+window.location.port+"/_graphite"`
  - `window.location.protocol+"//"+window.location.hostname+":"+window.location.port`

  The idea is to allow external access without `CORS` problems or credential leaks in `config.js`.

* Value for `default['grafana']['install_path']` changed from `/opt` to `/srv/apps` (Greg Fitzgerald) [#13](https://github.com/JonathanTron/chef-grafana/pull/13)
* Default installation uses zip file instead of git (Greg Fitzgerald) [#13](https://github.com/JonathanTron/chef-grafana/pull/13)

__minor changes__

* Major cleanup and additional tests (Greg Fitzgerald) [#13](https://github.com/JonathanTron/chef-grafana/pull/13)

## 1.0.6 (2014-06-17):

* Releasing to opscode community site [Thanks to @gregf in #12](https://github.com/JonathanTron/chef-grafana/pull/12)

## 1.0.5 (2014-06-17):

__breaking changes__

* `config.js` was unintentionally changed to use node info to configure graphite and elasticsearch index.
* Value for `default['grafana']['grafana_index']` changed from `grafana-dash` to `grafana-index` (Greg Fitzgerald) [#11](https://github.com/JonathanTron/chef-grafana/pull/11)
* Update grafana to 1.6.0 (Greg Fitzgerald) [#11](https://github.com/JonathanTron/chef-grafana/pull/11)

## 1.0.4 (2014-05-18):

* Update config.js based on the one in 1.5.4
* Update to grafana 1.5.4
* Update to new download URL

## 1.0.3 (2014-04-12):

* Add some basic specs, foodcritic, knife test and enable TravisCI

* Fix error with undefined grafana_user variable [Thanks to @klamontagne](https://github.com/JonathanTron/chef-grafana/commit/50fa3836dcf410e37b96533e25d952e8bc6c2472#commitcomment-5857007)

* Fix timezone value quoting in config.js (Anatoliy D.) [#9](https://github.com/JonathanTron/chef-grafana/pull/9)

* Update grafana to 1.5.2 (Grégoire Seux) [#7](https://github.com/JonathanTron/chef-grafana/pull/7)

* Don't set normal attribute `node['nginx']['default_site_enabled']` (Grégoire Seux) [#5](https://github.com/JonathanTron/chef-grafana/pull/5)

* Remove `"use strict";` from `config.js` as it seems to not be present in
  grafana releases, thanks to @iiro for proposing it in [#1](https://github.com/JonathanTron/chef-grafana/pull/1)

* Don't search when `node['grafana']['es_server']` or `node['grafana']['graphite_server']`
  is set and don't use normal attributes (Grégoire Seux) [#3](https://github.com/JonathanTron/chef-grafana/pull/3)

* Refactor and separate install in two recipes: `install_git` and `install_file`
  (Grégoire Seux) [#2](https://github.com/JonathanTron/chef-grafana/pull/2)

## 1.0.2 (2014-03-23):

* Update file release to 1.5.1

## 1.0.1 (2014-03-10):

* Update file release to 1.5.0

## 1.0.0 (2014-03-01):

* Initial release of grafana
