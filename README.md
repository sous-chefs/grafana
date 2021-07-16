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

## Requirements

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

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
