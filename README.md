# Grafana Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/grafana.svg?style=flat)](https://supermarket.chef.io/cookbooks/grafana)
[![CircleCI](https://img.shields.io/circleci/project/github/sous-chefs/grafana/master.svg)](https://circleci.com/gh/sous-chefs/grafana)

## Overview

This cookbook provides a complete installation and configuration of Grafana. This includes the ability to manage dashboards, datasources, orginizations, plugins and users with Chef using Custom Resources.

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

## Resources

* [grafana_config](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config.md)
* [grafana_config_alerting](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_alerting.md)
* [grafana_config_auth](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_auth.md)
* [grafana_config_dashboards](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_dashboards.md)
* [grafana_config_database](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_database.md)
* [grafana_config_dataproxy](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_dataproxy.md)
* [grafana_config_emails](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_emails.md)
* [grafana_config_enterprise](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_enterprise.md)
* [grafana_config_explore](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_explore.md)
* [grafana_config_log](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_log.md)
* [grafana_config_ldap](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_ldap.md)
* [grafana_config_ldap_group_mappings](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_ldap_group_mappings.md)
* [grafana_config_ldap_servers](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_ldap_servers.md)
* [grafana_config_metrics](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_metrics.md)
* [grafana_config_panels](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_panels.md)
* [grafana_config_paths](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_paths.md)
* [grafana_config_quotas](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_quotas.md)
* [grafana_config_security](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_security.md)
* [grafana_config_server](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_server.md)
* [grafana_config_session](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_session.md)
* [grafana_config_smtp](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_smtp.md)
* [grafana_config_snapshots](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_snapshots.md)
* [grafana\_config\_external\_image\_storage](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_external_image_storage.md)
* [grafana_config_users](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_config_users.md)
* [grafana_dashboard](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_dashboard.md)
* [grafana_datasource](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_datasource.md)
* [grafana_install](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_install.md)
* [grafana_orginization](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_orginization.md)
* [grafana_plugin](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_plugin.md)
* [grafana_user](https://github.com/sous-chefs/grafana/tree/master/documentation/grafana_user.md)

## License & Authors

* Author:: Jason Field (https://github.com/xorima)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. jhenry82

Based on `chef-kibana` cookbook by:

- John E. Vincent [lusis.org+github.com@gmail.com](mailto:lusis.org+github.com@gmail.com)
