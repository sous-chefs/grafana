# CHANGELOG for grafana

This file is used to list changes made in each version of grafana.

## DEV:

* Remove `"use strict";` from `config.js` as it seems to not be present in
  grafana releases, thanks to @iiro for proposing it in [#1](https://github.com/JonathanTron/chef-grafana/pull/1)

* Don't search when `node['grafana']['es_server']` or `node['grafana']['graphite_server']`
  is set and don't use normal attributes (Grégoire Seux) [#3](https://github.com/JonathanTron/chef-grafana/pull/3)

* Refactor and separate install in two recipes: `install_git` and `install_file`
  (Grégoire Seux) [#2](https://github.com/JonathanTron/chef-grafana/pull/2)

## 1.0.2:

* Update file release to 1.5.1

## 1.0.1:

* Update file release to 1.5.0

## 1.0.0:

* Initial release of grafana
