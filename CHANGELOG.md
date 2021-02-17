# CHANGELOG for grafana

This file is used to list changes made in each version of grafana.

## 9.6.0 - *2021-02-17*

- Added `allow_loading_unsigned_plugins` management

## 9.5.2 - *2021-01-16*

- Fixed docuemntation showing the incorrect action
- Fixed a bug where ldap and grafana had hard coded paths.

## 9.5.1 - 2020-11-18

- Removed duplicate attribute (#389)

## 9.5.0 - 2020-10-05

- Added support for cookie_samesite settings (#383)

## 9.4.1 - 2020-08-31

- Bugfix for undefined port variable (#381)

## 9.4.0 - 2020-08-31

- Added support for HTTPS endpoint
- Added support for endpoints with url_path_prefix
- Fixed url_path_prefix property definition in resources

## 9.3.0 - 2020-08-19

- Added support for use of config_writer to only generate config file when grafana is not present on host

## 9.2.1

- Fixed tests to not require `chef_sleep`
- Added support for centos-8
- Added support for debian-10
- Added support for amazonlinux-2
- Removes support for debian-8
- Added support to retrieve org id by name
- Added support for backing up datasources and dashboards to file
- Added support for custom plugin URLs
- Added support for creating dashboards from template file
- Fixes bug that didn't create folder when using action update and it did not exist yet
- Fixes bug that didn't create datasource when using action update and it did not exist yet
- Fixes bug where installing a lot of plugins would cause grafana systemd service to fail to start
- Removes unecessary restart on plugin install

## 9.1.0

- Add in support for `min_refresh_interval` configuration to dashboard config.
- Adds support for Ubuntu 20.04
- resolved cookstyle error: resources/config_server.rb:25:59 refactor: `ChefCorrectness/LazyEvalNodeAttributeDefaults`
- Removes support for Ubuntu 16.04
- Removes support for centos 6
- Removes support for amazonlinux 1
- Improved stability in flakey tests using chef_sleep
- Minimum chef version is now 15.5

## 8.8.0

- Add in support for configuring rendering service

## 8.7.1

- Fixes bug in dashboard library where request would return nil

## 8.7.0

- Add in support for Azure AD authentication <https://grafana.com/docs/grafana/latest/auth/azuread/>

## 8.6.0

- Add in support for `cookie_secure` configuration option to security config.
- Add in support for `login_maximum_lifetime_days` config option to set the cookie lifetime in days

## 8.5.0

- Adding support for change to Grafana session cookie name.  See README for details

## 8.4.2

- Bugfix: fix the value types in the ldap.toml file
- Add tests to make sure ldap.toml file is matching requirements

## 8.4.1

- Bugfix: fix the value types in the ldap.toml file

## 8.4.0

- Allow multiple LDAP mapping with the same group_dn

## 8.3.0

- Adds role mapping to generic oauth resource <https://grafana.com/docs/grafana/latest/auth/generic-oauth/#role-mapping>

## 8.2.0

- Bugfix for grafana_folder resource
- Add organization support to grafana_folder
- Migrate CI system to Github Actions

## 8.1.1 (2019-12-22)

- Fix sensitive property of config_writer resource

## 8.1.0 (2019-11-26)

- Generate Folder and folder permissions using Custom Resources

## 8.0.0

- Changed `ldap_config_servers` `host` property from name property to required property
- Changed `ldap_config_group_mappings` `group_dn` property from name_property to required property
- Added `instance_name` to above resources as name property
- Changed ldap config template from @grafana['ldap'] to @LDAP
- Changed `grafana_config`
  - Property `restart_on_upgrade` now expects `true` or `false`
- Changed `grafana_config_database`
  - Property `type` now expects a symbol
  - Property `ssl_mode` now expects a symbol or true/false
- Changed `grafana_config_remote_cache`
  - Property `remote_cache_type` now expects a symbol
- Changed `grafana_config_server`
  - Property `protocol` now expects a symbol
- Changed `grafana_config_session`
  - Property `session_provider` now expects a symbol
- Changed `grafana_config_users`
  - Property `default_theme` now expects a symbol

- Removed the requirement to handle services outside of resources, `config_writer` now restarts when requested
- Removed config directory from all config resource
- Removed config file from all config resource
- Removed cookbook from all config resource
- Removed source from all config resource

- Added resource called config_writer to output the config file
- Added sensitive flag on config_writer
- Added additional tests around `grafana_user` with `proxy` authentication
- Added additional tests around all api resources under the `configuration` kitchen tests

## 7.1.1

- Fix issue with wrong setting being configured in the log section

## 7.1.0

- Add option for `serve_from_sub_path` in grafana_config_server

## 7.0.0

- Resolves issue with service restarts using external service resources
- Resolved the latest cookstyle issues

## 6.0.1

- Removed misconfigured duplicate router_logging String property from config_server resource
- Now correct Grafana version can be specified for installing/upgrading
  on Debian based systems.

## 6.0.0

- Fixed type specification of group_search_dns to be Array instead
  of incorrect String previously.
- Cookstyle fixes around `long_description` and header formats

## 5.1.1 (2019-08-16)

- Fixed `address` appearing as `basic_auth_password` for internal metrics

## 5.1.0 (2019-07-26)

- After modifying config files, grafana-server is restarted
- Fixed session `provider`
- Added remote-cache config support

## 5.0.0 (2019-06-20)

- Allow custom database names
- After modifying plugins, grafana-server is restarted
- Added property for `enable_embedding` in `config_security`
- Api helper will now retry for `EADDRNOTAVAIL`

## 4.4.0 (2019-05-21)

- grafana_plugin now works
- Migrated to new circleci orb
- Depreciated testing on fedora and opensuse

## 4.3.0 (2019-05-16)

- Aligned grafana_config_auth `login_cookie_name` default to rest of cookbook
- Add API resource support for proxy_auth
- Added PATCH support to the org library

## 4.2.0 (2019-05-14)

- Fixed misspelling of `oath` to `oauth`

## 4.1.0 (2019-04-26)

- Added feature to enable AWS S3 based external image storage.

## 4.0.2 (2019-04-14)

- Fixes several issues in LDAP resources and template.

## 4.0.1 (2019-04-2)

- Added support for Amazon Linux 2

## 4.0.0 (2019-03-24)

- Migrate existing LWRP to Custom Resources
- Create new config resources to be able to configure the grafana instance
- Created new ldap config resources
- Create install resource to install Grafana, does not do any configuration
- Update repo location to new grafana repos (#220)
- Add login_cookie_name property to config_auth resource
- Add root_url property to config_server resource
- Added documentation for all new resources

## 3.0.1 (2018-11-27)

- Add support for amazon. Chef 13 and later identifies platform_family as 'amazon': <https://docs.chef.io/deprecations_ohai_amazon_linux.html>
- Update to Grafana 5.3.4
- Drop support for Ubuntu 14.04
- Add support for Ubuntu 18.04

## 3.0.0 (2018-04-29)

- Require Chef 13 or later
- Remove use_inline_resources and why_run statements from LWRPs which are no longer necessary with Chef 13+
- Remove the dependency on apt/yum cookbooks since we can setup apt/yum repositories with Chef 13
- Switch package installs to multi-package installs to speed up Chef runs
- Remove the 'name' LWRP properties since Chef creates these automatically for us
- Switch testing to InSpec / Delivery local mode
- Add codeowners, contributing.md, and codeofconduct.md files
- Fix failures in the ChefSpecs and simplify the specs
- Remove ChefSpec matchers since these are autogenerated by ChefSpec now
- Sped up ChefSpec runtimes by enabling caching
- Drop support for Debian 7 since it goes EOL in a few weeks

## 2.2.1 (2018-04-03)

- Add exception handling for JSON::ParserError [#155](https://github.com/sous-chefs/chef-grafana/pull/155) by [@ton31337](https://github.com/ton31337)
- new attribute node[grafana][restart_on_upgrade] [#164](https://github.com/sous-chefs/chef-grafana/pull/164) by [InformatiQ](https://github.com/InformatiQ)
- Switch to `nginx` cookbook to create the nginx site instead of manually templating out the file

## 2.2.0 (2017-10-12)

- Switch to linter `cookstyle`
- Fix serverspec tests [#180](https://github.com/sous-chefs/chef-grafana/pull/180)
- Upgrade grafana version
- Fix env file

## 2.1.3 (2015-08-24)

- Fix a bug in error message handling code [#80](https://github.com/JonathanTron/chef-grafana/issues/80)

## 2.1.2 (2015-08-24)

- Fix Grafana package checksums [#79](https://github.com/JonathanTron/chef-grafana/issues/79)

## 2.1.1 (2015-08-20)

- Update Grafana default version to 2.1.2
- Ensure we're displaying better messages in some edge cases with HTTP requests [#76](https://github.com/JonathanTron/chef-grafana/issues/76)

## 2.1.0 (2015-08-17)

- Update Grafana default version to 2.1.1
- Make sure upgrading via deb file don't fail on configuration conflict [#74](https://github.com/JonathanTron/chef-grafana/issues/74)
- Ensure installing a new version trigger a server restart
- Add packages checksum to ensure expected file and prevent unecessary re-download (see warnings section below)
- Installation package file only if present and/or modified (@arifcse019) [#73](https://github.com/JonathanTron/chef-grafana/pull/73)
- Fix start service making it just be restarted at the end of the configuration (@HelioCampos) [#71](https://github.com/JonathanTron/chef-grafana/pull/71)
- Improve error messages during dashboard creation [#64](https://github.com/JonathanTron/chef-grafana/pull/64)
- Update ServerSpec test to check `:stderr` for curl output

When using the default's file installation, we've added checksum for package files if you set the grafana version to something different than the default you will also need set the checksum for the package you're expecting to use:

```ruby
# Example if your Grafana version is different from the cookbook default
node['grafana']['version'] = '2.1.0'
# For debian platform family
node['grafana']['file']['checksum']['deb'] = 'b824c8358ff07f76f0d9eb35e9441f6f9e591819ad8bc70db4b0c904a8e7130e'
# For rhel platform family
node['grafana']['file']['checksum']['rpm'] = '1b436b286bd464e65eeb2a9b393da0986569fe483e1053b01c092b2e590d8399'
```

## 2.0.0 (2015-06-28)

- Major overhaul of the cookbook to support Grafana 2.x

## 1.x dev

- Ensure setting `node['grafana']['listen_address']` to `nil` render a valid nginx config file (@lanyonm) [#39](https://github.com/JonathanTron/chef-grafana/pull/39)

## 1.5.5 (2015-03-29)

- Update `elasticsearch` git url in `Berksfile` for elasticsearch to elastic rename (@lanyonm) [#38](https://github.com/JonathanTron/chef-grafana/pull/38)
- Allow nginx to listen on all interface when `node['grafana']['webserver_listen']` is `nil` or `false` (@BackSlasher) [#37](https://github.com/JonathanTron/chef-grafana/pull/37)
- Fix base64 encoding appending a newline in nginx config for basic auth (@BackSlasher) [#36](https://github.com/JonathanTron/chef-grafana/pull/36)

## 1.5.4 (2015-02-22)

- Update `Grafana` to `1.9.1` (@osigida) [#32](https://github.com/JonathanTron/chef-grafana/pull/32)
- Interpolate "version" and "type" attributes to build grafana file url (Bernhard Köhler) [#31](https://github.com/JonathanTron/chef-grafana/pull/31) and (Olivier Bazoud) [#29](https://github.com/JonathanTron/chef-grafana/issues/29)
- Add support for lambdas in datasources. This change makes it possible to evaluate derived attributes correctly. (Bernhard Köhler) [#30](https://github.com/JonathanTron/chef-grafana/pull/30) and [#25](https://github.com/JonathanTron/chef-grafana/issues/25)

## 1.5.3 (2014-11-15)

- Add support for Centos[#28](https://github.com/JonathanTron/chef-grafana/issues/28)

## 1.5.2 (2014-11-04)

- Allow configuration of `default_route` via attributes (Miguel Landaeta) [#26](https://github.com/JonathanTron/chef-grafana/pull/26)
- Add support for grafana admin password option (Andrew Goktepe) [#23](https://github.com/JonathanTron/chef-grafana/pull/23)

## 1.5.1 (2014-10-08)

- Update `Grafana` to `1.8.1`

## 1.5.0 (2014-09-22)

- Update `Grafana` to `1.8.0`

## **warning**

- Check for the presence of `node['grafana']['es_role']` and `node['grafana']['graphite_role']` instead of `node['grafana']['es_server']` and `node['grafana']['graphite_server']` to know if we should search and replace `default['grafana']['es_server']` and `default['grafana']['graphite_server']` (Jonathon W. Marshall) [#22](https://github.com/JonathanTron/chef-grafana/pull/22)

## 1.4.2 (2014-09-14)

- Fix attributes doc in README

## 1.4.1 (2014-09-12)

- Do not use `template` resource's `helpers` method to bring back older `Chef` compatibility.

## 1.4.0 (2014-09-12)

- Update `Grafana` to `1.8.0-rc1`
- Add `default['grafana']['window_title_prefix']` and `default['grafana']['search_max_results']` config attributes.

## **warnings**

- `Grafana 1.8.0-rc1` upgraded to `JQuery` to `2.1.1` and thus dropped support for `Internet Explorer 7 and 8`

## 1.3.4 (2014-08-19)

- Update attributes in README for better Supermarket display
- Update `foodcritic` and `rubocop` (Tim Smith) [#21](https://github.com/JonathanTron/chef-grafana/pull/21)
- Remove mention of `zipfile` in README and attributes (Thanks to Gref Fitzgerald)
- Fix `default['grafana']['install_type']` documentation to have the correct possible values: `git` and `file` (Fred Hatfull) [#20](https://github.com/JonathanTron/chef-grafana/pull/20)
- Fix `default['grafana']['webserver']` documentation not to include `apache` as possible value. (osigida) [#19](https://github.com/JonathanTron/chef-grafana/pull/19)

## 1.3.2 (2014-08-12)

- Update default `Grafana` to `1.7.0`. (Greg Fitzgerald) [#18](https://github.com/JonathanTron/chef-grafana/pull/18).

## 1.3.1 (2014-08-07)

- Update `Grafana` to `1.7.1-rc1`. It fixes a regression introduced when merging [#16](https://github.com/JonathanTron/chef-grafana/pull/16). Thanks to Greg Fitzgerald for reporting it.

## 1.3.0 (2014-07-31)

- Allow attribute configuration for datasources (Grégoire Seux) [#16](https://github.com/JonathanTron/chef-grafana/pull/16)

## 1.2.0 (2014-07-11)

### breaking changes

- Update `ark` dependency to `>= 0.7.2` and deprecation warning by using `strip_component` (Grégoire Seux) [#15](https://github.com/JonathanTron/chef-grafana/pull/14)

### minor changes

- Support newer `nginx` cookbook by specifying `template: false` when enabling the `grafana` site (Grégoire Seux) [#15](https://github.com/JonathanTron/chef-grafana/pull/14)

## 1.1.1 (2014-07-10)

- Update default attributes to install Grafana 1.6.1 (Greg Fitzgerald) [#14](https://github.com/JonathanTron/chef-grafana/pull/14)

## 1.1.0 (2014-06-20)

- `config.js` data for `graphite` and `elasticsearch` changed back to use:
- `window.location.protocol+"//"+window.location.hostname+":"+window.location.port+"/_graphite"`
  - `window.location.protocol+"//"+window.location.hostname+":"+window.location.port`

  The idea is to allow external access without `CORS` problems or credential leaks in `config.js`.

- Value for `default['grafana']['install_path']` changed from `/opt` to `/srv/apps` (Greg Fitzgerald) [#13](https://github.com/JonathanTron/chef-grafana/pull/13)

- Default installation uses zip file instead of git (Greg Fitzgerald) [#13](https://github.com/JonathanTron/chef-grafana/pull/13)
- Major cleanup and additional tests (Greg Fitzgerald) [#13](https://github.com/JonathanTron/chef-grafana/pull/13)

## 1.0.6 (2014-06-17)

- Releasing to opscode community site [Thanks to @gregf in #12](https://github.com/JonathanTron/chef-grafana/pull/12)

## 1.0.5 (2014-06-17)

- `config.js` was unintentionally changed to use node info to configure graphite and elasticsearch index.
- Value for `default['grafana']['grafana_index']` changed from `grafana-dash` to `grafana-index` (Greg Fitzgerald) [#11](https://github.com/JonathanTron/chef-grafana/pull/11)
- Update grafana to 1.6.0 (Greg Fitzgerald) [#11](https://github.com/JonathanTron/chef-grafana/pull/11)

## 1.0.4 (2014-05-18)

- Update config.js based on the one in 1.5.4
- Update to grafana 1.5.4
- Update to new download URL

## 1.0.3 (2014-04-12)

- Add some basic specs, foodcritic, knife test and enable TravisCI
- Fix error with undefined grafana_user variable [Thanks to @klamontagne](https://github.com/JonathanTron/chef-grafana/commit/50fa3836dcf410e37b96533e25d952e8bc6c2472#commitcomment-5857007)
- Fix timezone value quoting in config.js (Anatoliy D.) [#9](https://github.com/JonathanTron/chef-grafana/pull/9)
- Update grafana to 1.5.2 (Grégoire Seux) [#7](https://github.com/JonathanTron/chef-grafana/pull/7)
- Don't set normal attribute `node['nginx']['default_site_enabled']` (Grégoire Seux) [#5](https://github.com/JonathanTron/chef-grafana/pull/5)
- Remove `"use strict";` from `config.js` as it seems to not be present in grafana releases, thanks to @iiro for proposing it in [#1](https://github.com/JonathanTron/chef-grafana/pull/1)
- Don't search when `node['grafana']['es_server']` or `node['grafana']['graphite_server']` is set and don't use normal attributes (Grégoire Seux) [#3](https://github.com/JonathanTron/chef-grafana/pull/3)
- Refactor and separate install in two recipes: `install_git` and `install_file` (Grégoire Seux) [#2](https://github.com/JonathanTron/chef-grafana/pull/2)

## 1.0.2 (2014-03-23)

- Update file release to 1.5.1

## 1.0.1 (2014-03-10)

- Update file release to 1.5.0

## 1.0.0 (2014-03-01)

- Initial release of grafana
