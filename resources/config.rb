#
# Cookbook Name:: grafana
# Resource:: config
#
# Copyright 2014, Jonathan Tron
# Copyright 2017, Andrei Skopenko
# Copyright 2018, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures the installed grafana instance

property  :instance_name,                                         String,         name_property: true
property  :env_directory,                                         String,         default: '/etc/default'
property  :owner,                                                 String,         default: 'grafana'
property  :group,                                                 String,         default: 'grafana'
property  :restart_on_upgrade,                                    String,         default: 'false'
property  :conf_directory,                                        String,         default: '/etc/grafana'
property  :config_file,                                           String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :app_mode,                                              String,         default: 'production', equal_to: %w(production development)
property  :paths_data,                                            String,         default: 'data'
property  :paths_temp_data_lifetime,                              String,         default: '24h'
property  :paths_logs,                                            String,         default: 'data/log'
property  :paths_plugins,                                         String,         default: 'data/plugins'
property  :paths_provisioning,                                    String,         default: 'conf/provisioning'
property  :server_protocol,                                       String,         default: 'http', equal_to: %w(http https socket)
property  :server_http_addr,                                      String,         default: ''
property  :server_http_port,                                      Integer,        default: 3000
property  :server_domain,                                         String,         default: node['hostname']
property  :server_enforce_domain,                                 [true, false],  default: false
property  :server_router_logging,                                 [true, false],  default: false
property  :server_static_root_path,                               String,         default: 'public'
property  :server_enable_gzip,                                    [true, false],  default: false
property  :server_cert_file,                                      String,         default: ''
property  :server_cert_key,                                       String,         default: ''
property  :server_router_logging,                                 String,         default: '/tmp/grafana.sock'
property  :database_type,                                         String,         default: 'sqlite3', equal_to: %w(mysql postgres sqlite3)
property  :database_host,                                         String,         default: '127.0.0.1:3306'
property  :database_name,                                         String,         default: 'grafana'
property  :database_user,                                         String,         default: 'root'
property  :database_password,                                     String,         default: ''
property  :database_max_idle_conn,                                Integer,        default: 2
property  :database_max_opem_conn,                                Integer,        default: 0
property  :database_conn_max_lifetime,                            Integer,        default: 14400
property  :database_log_queries,                                  [true, false],  default: false
property  :database_ssl_mode,                                     String,         default: 'disable', equal_to: %w(disable require verify-full true false skip-verify)
property  :database_ca_cert_path,                                 String,         default: ''
property  :database_client_key_path,                              String,         default: ''
property  :database_client_cert_path,                             String,         default: ''
property  :database_server_cert_name,                             String,         default: ''
property  :database_path,                                         String,         default: 'grafana.db'
property  :session_provider,                                      String,         default: 'file', equal_to: %w(memory file redis mysql postgres memcache)
property  :session_provider_config,                               String,         default: 'sessions'
property  :session_cookie_name,                                   String,         default: 'grafana_sess'
property  :session_cookie_secure,                                 [true, false],  default: false
property  :session_session_life_time,                             Integer,        default: 86400
property  :session_gc_interval_time,                              Integer,        default: 86400
property  :session_conn_max_lifetime,                             Integer,        default: 14400
property  :dataproxy_logging,                                     [true, false],  default: false
property  :security_admin_user,                                   String,         default: 'admin'
property  :security_admin_password,                               String,         default: 'admin'
property  :security_secret_key,                                   String,         default: 'SW2YcwTIb9zpOOhoPsMm'
property  :security_login_remember_days,                          Integer,        default: 7
property  :security_cookie_username,                              String,         default: 'grafana_user'
property  :security_cookie_remember_name,                         String,         default: 'grafana_remember'
property  :security_disable_gravatar,                             [true, false],  default: false
property  :security_data_source_proxy_whitelist,                  String,         default: ''
property  :security_disable_brute_force_login_protection,         [true, false],  default: false
property  :snapshots_external_enabled,                            [true, false],  default: true
property  :snapshots_external_snapshot_url,                       String,         default: 'https://snapshots-origin.raintank.io'
property  :snapshots_external_snapshot_name,                      String,         default: 'Publish to snapshot.raintank.io'
property  :snapshots_snapshot_remove_expired,                     [true, false],  default: true
property  :dashboards_versions_to_keep,                           Integer,        default: 20
property  :users_allow_sign_up,                                   [true, false],  default: false
property  :users_allow_org_create,                                [true, false],  default: false
property  :users_auto_assign_org,                                 [true, false],  default: true
property  :users_auto_assign_org_id,                              Integer,        default: 1
property  :users_auto_assign_org_role,                            String,         default: 'Viewer'
property  :users_verify_email_enabled,                            [true, false],  default: false
property  :users_login_hint,                                      String,         default: 'email or username'
property  :users_default_theme,                                   String,         default: 'dark', equal_to: %w(dark light)
property  :users_external_manage_link_url,                        String,         default: ''
property  :users_external_manage_link_name,                       String,         default: ''
property  :users_external_manage_info,                            String,         default: ''
property  :users_viewers_can_edit,                                [true, false],  default: false
property  :auth_disable_login_form,                               [true, false],  default: false
property  :auth_disable_signout_menu,                             [true, false],  default: false
property  :auth_signout_redirect_url,                             String,         default: ''
property  :auth_oauth_auto_login,                                 [true, false],  default: false
property  :auth_anonymous_enabled,                                [true, false],  default: false
property  :auth_anonymous_org_name,                               String,         default: 'Main Org.'
property  :auth_anonymous_org_role,                               String,         default: 'Viewer'
property  :auth_github_enabled,                                   [true, false],  default: false
property  :auth_github_allow_sign_up,                             [true, false],  default: true
property  :auth_github_client_id,                                 String,         default: ''
property  :auth_github_client_secret,                             String,         default: ''
property  :auth_github_scopes,                                    String,         default: ''
property  :auth_github_auth_url,                                  String,         default: 'https://github.com/login/oauth/authorize'
property  :auth_github_token_url,                                 String,         default: 'https://github.com/login/oauth/access_token'
property  :auth_github_api_url,                                   String,         default: 'https://api.github.com/user'
property  :auth_github_team_ids,                                  String,         default: ''
property  :auth_github_allowed_organizations,                     String,         default: ''
property  :auth_gitlab_enabled,                                   [true, false],  default: false
property  :auth_gitlab_allow_sign_up,                             [true, false],  default: true
property  :auth_gitlab_client_id,                                 String,         default: ''
property  :auth_gitlab_client_secret,                             String,         default: ''
property  :auth_gitlab_scopes,                                    String,         default: ''
property  :auth_gitlab_auth_url,                                  String,         default: 'https://gitlab.com/oauth/authorize'
property  :auth_gitlab_token_url,                                 String,         default: 'https://gitlab.com/oauth/token'
property  :auth_gitlab_api_url,                                   String,         default: 'https://gitlab.com/api/v4'
property  :auth_gitlab_allowed_groups,                            String,         default: ''
property  :auth_google_enabled,                                   [true, false],  default: false
property  :auth_google_allow_sign_up,                             [true, false],  default: true
property  :auth_google_client_id,                                 String,         default: ''
property  :auth_google_client_secret,                             String,         default: ''
property  :auth_google_scopes,                                    String,         default: 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
property  :auth_google_auth_url,                                  String,         default: 'https://accounts.google.com/o/oauth2/auth'
property  :auth_google_token_url,                                 String,         default: 'https://accounts.google.com/o/oauth2/token'
property  :auth_google_api_url,                                   String,         default: 'https://www.googleapis.com/oauth2/v1/userinfo'
property  :auth_google_allowed_domains,                           String,         default: ''
property  :auth_google_hosted_domain,                             String,         default: ''
property  :auth_grafananet_enabled,                               [true, false],  default: false
property  :auth_grafananet_allow_sign_up,                         [true, false],  default: true
property  :auth_grafananet_client_id,                             String,         default: ''
property  :auth_grafananet_client_secret,                         String,         default: ''
property  :auth_grafananet_scopes,                                String,         default: 'user:email'
property  :auth_grafananet_allowed_organizations,                 String,         default: ''
property  :auth_grafanacom_enabled,                               [true, false],  default: false
property  :auth_grafanacom_allow_sign_up,                         [true, false],  default: true
property  :auth_grafanacom_client_id,                             String,         default: ''
property  :auth_grafanacom_client_secret,                         String,         default: ''
property  :auth_grafanacom_scopes,                                String,         default: 'user:email'
property  :auth_grafanacom_allowed_organizations,                 String,         default: ''
property  :auth_generic_oath_name,                                String,         default: 'OAuth'
property  :auth_generic_oath_enabled,                             [true, false],  default: false
property  :auth_generic_oath_allow_sign_up,                       [true, false],  default: true
property  :auth_generic_oath_client_id,                           String,         default: ''
property  :auth_generic_oath_client_secret,                       String,         default: ''
property  :auth_generic_oath_scopes,                              String,         default: 'user:email'
property  :auth_generic_oath_email_attribute_name,                String,         default: 'email:primary'
property  :auth_generic_oath_auth_url,                            String,         default: ''
property  :auth_generic_oath_token_url,                           String,         default: ''
property  :auth_generic_oath_api_url,                             String,         default: ''
property  :auth_generic_oath_team_ids,                            String,         default: ''
property  :auth_generic_oath_allowed_organizations,               String,         default: ''
property  :auth_generic_oath_tls_skip_verify_insecure,            [true, false],  default: false
property  :auth_generic_oath_tls_client_cert,                     String,         default: ''
property  :auth_generic_oath_tls_client_key,                      String,         default: ''
property  :auth_generic_oath_tls_client_ca,                       String,         default: ''
property  :auth_generic_oath_send_client_credentials_via_post,    [true, false],  default: false
property  :auth_basic_enabled,                                    [true, false],  default: true
property  :auth_proxy_enabled,                                    [true, false],  default: false
property  :auth_proxy_header_name,                                String,         default: 'X-WEBAUTH-USER'
property  :auth_proxy_header_property,                            String,         default: 'username'
property  :auth_proxy_auto_sign_up,                               [true, false],  default: true
property  :auth_proxy_ldap_sync_ttl,                              Integer,        default: 60
property  :auth_proxy_whitelist,                                  String,         default: ''
property  :auth_proxy_headers,                                    String,         default: ''
property  :auth_ldap_enabled,                                     [true, false],  default: false
property  :auth_ldap_config_file,                                 String,         default: '/etc/grafana/ldap.toml'
property  :auth_ldap_allow_sign_up,                               [true, false],  default: true
property  :smtp_enabled,                                          [true, false],  default: false
property  :smtp_host,                                             String,         default: 'localhost:25'
property  :smtp_user,                                             String,         default: ''
property  :smtp_password,                                         String,         default: ''
property  :smtp_cert_file,                                        String,         default: ''
property  :smtp_key_file,                                         String,         default: ''
property  :smtp_skip_verify,                                      [true, false],  default: false
property  :smtp_from_address,                                     String,         default: "admin@grafana.#{node['hostname']}"
property  :smtp_from_name,                                        String,         default: 'Grafana'
property  :smtp_ehlo_identity,                                    String,         default: ''
property  :emails_welcome_email_on_sign_up,                       [true, false],  default: false
property  :emails_templates_pattern,                              String,         default: 'emails/*.html'
property  :log_mode,                                              String,         default: 'console file'
property  :log_level,                                             String,         default: 'info'
property  :log_filters,                                           String,         default: ''
property  :log_console_level,                                     String,         default: ''
property  :log_console_format,                                    String,         default: 'console'
property  :log_file_level,                                        String,         default: ''
property  :log_file_format,                                       String,         default: 'text'
property  :log_file_log_rotate,                                   [true, false],  default: true
property  :log_file_max_lines,                                    Integer,        default: 1000000
property  :log_file_max_size_shift,                               Integer,        default: 28
property  :log_file_daily_rotate,                                 [true, false],  default: true
property  :log_file_max_days,                                     Integer,        default: 7
property  :log_syslog_level,                                      String,         default: ''
property  :log_syslog_format,                                     String,         default: 'text'
property  :log_syslog_network,                                    String,         default: ''
property  :log_syslog_address,                                    String,         default: ''
property  :log_syslog_facility,                                   String,         default: ''
property  :log_syslog_tag,                                        String,         default: ''
property  :quota_enabled,                                         [true, false],  default: false
property  :quota_org_user,                                        Integer,        default: 10
property  :quota_org_dashboard,                                   Integer,        default: 100
property  :quota_org_data_source,                                 Integer,        default: 10
property  :quota_org_api_key,                                     Integer,        default: 10
property  :quota_user_org,                                        Integer,        default: 10
property  :quota_global_user,                                     Integer,        default: -1
property  :quota_global_org,                                      Integer,        default: -1
property  :quota_global_dashboard,                                Integer,        default: -1
property  :quota_global_api_key,                                  Integer,        default: -1
property  :quota_global_session,                                  Integer,        default: -1
property  :alerting_enabled,                                      [true, false],  default: true
property  :alerting_execute_alerts,                               [true, false],  default: true
property  :alerting_error_or_timeout,                             String,         default: 'alerting'
property  :alerting_nodata_or_nullvalues,                         String,         default: 'no_data'
property  :alerting_concurrent_render_limit,                      Integer,        default: 5
property  :explore_enabled,                                       [true, false],  default: false
property  :metrics_enabled,                                       [true, false],  default: true
property  :metrics_interval_seconds,                              Integer,        default: 10
property  :metrics_basic_auth_username,                           String,         default: ''
property  :metrics_basic_auth_password,                           String,         default: ''
property  :metrics_graphite_address,                              String,         default: ''
property  :metrics_graphite_prefix,                               String,         default: 'prod.grafana.%(instance_name)s.'
property  :panels_enable_alpha,                                   [true, false],  default: false
property  :enterprise_license_path,                               String,         default: ''
action :install do
  user new_resource.owner do
  end

  group new_resource.group do
  end

  directory new_resource.conf_directory do
    owner new_resource.owner
    group new_resource.group
    mode  '0750'
  end

  template ::File.join(new_resource.env_directory, 'grafana-server') do
    source 'grafana-env.erb'
    variables(
      grafana_user: new_resource.owner,
      grafana_group: new_resource.group,
      grafana_home: "/usr/share/#{new_resource.owner}",
      conf_dir: new_resource.conf_directory,
      pid_dir: '/var/run/grafana',
      restart_on_upgrade: new_resource.restart_on_upgrade
    )
    mode '0644'
    notifies :restart, 'service[grafana-server]', :delayed
  end

  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source lazy { node.run_state['grafana']['conf_template_source'][new_resource.config_file] ||= 'grafana.ini.erb' }
      cookbook lazy { node.run_state['grafana']['conf_cookbook'][new_resource.config_file] ||= 'grafana' }
      variables['grafana'] ||= {}

      variables['grafana']['root'] ||= {}
      variables['grafana']['root']['instance_name'] ||= '' unless new_resource.instance_name.nil?
      variables['grafana']['root']['instance_name'] << new_resource.instance_name.to_s unless new_resource.instance_name.nil?
      variables['grafana']['root']['app_mode'] ||= '' unless new_resource.app_mode.nil?
      variables['grafana']['root']['app_mode'].<< new_resource.app_mode.to_s unless new_resource.app_mode.nil?

      variables['grafana']['enterprise'] ||= {}
      variables['grafana']['enterprise']['license_path'] ||= '' unless new_resource.enterprise_license_path.nil?
      variables['grafana']['enterprise']['license_path'] << new_resource.enterprise_license_path.to_s unless new_resource.enterprise_license_path.nil?

      variables['grafana']['paths'] ||= {}
      variables['grafana']['paths']['data'] ||= '' unless new_resource.paths_data.nil?
      variables['grafana']['paths']['data'] << new_resource.paths_data.to_s unless new_resource.paths_data.nil?
      variables['grafana']['paths']['temp_data_lifetime'] ||= '' unless new_resource.paths_temp_data_lifetime.nil?
      variables['grafana']['paths']['temp_data_lifetime'] << new_resource.paths_temp_data_lifetime.to_s unless new_resource.paths_temp_data_lifetime.nil?
      variables['grafana']['paths']['logs'] ||= '' unless new_resource.paths_logs.nil?
      variables['grafana']['paths']['logs'] << new_resource.paths_logs.to_s unless new_resource.paths_logs.nil?
      variables['grafana']['paths']['plugins'] ||= '' unless new_resource.paths_plugins.nil?
      variables['grafana']['paths']['plugins'] << new_resource.paths_plugins.to_s unless new_resource.paths_plugins.nil?
      variables['grafana']['paths']['provisioning'] ||= '' unless new_resource.paths_provisioning.nil?
      variables['grafana']['paths']['provisioning'] << new_resource.paths_provisioning.to_s unless new_resource.paths_provisioning.nil?

      variables['grafana']['server'] ||= {}
      variables['grafana']['server']['protocol'] ||= '' unless new_resource.server_protocol.nil?
      variables['grafana']['server']['protocol'] << new_resource.server_protocol.to_s unless new_resource.server_protocol.nil?
      variables['grafana']['server']['http_addr'] ||= '' unless new_resource.server_http_addr.nil?
      variables['grafana']['server']['http_addr'] << new_resource.server_http_addr.to_s unless new_resource.server_http_addr.nil?
      variables['grafana']['server']['http_port'] ||= '' unless new_resource.server_http_port.nil?
      variables['grafana']['server']['http_port'] << new_resource.server_http_port.to_s unless new_resource.server_http_port.nil?
      variables['grafana']['server']['domain'] ||= '' unless new_resource.server_domain.nil?
      variables['grafana']['server']['domain'] << new_resource.server_domain.to_s unless new_resource.server_domain.nil?
      variables['grafana']['server']['enforce_domain'] ||= '' unless new_resource.server_enforce_domain.nil?
      variables['grafana']['server']['enforce_domain'] << new_resource.server_enforce_domain.to_s unless new_resource.server_enforce_domain.nil?
      variables['grafana']['server']['router_logging'] ||= '' unless new_resource.server_router_logging.nil?
      variables['grafana']['server']['router_logging'] << new_resource.server_router_logging.to_s unless new_resource.server_router_logging.nil?
      variables['grafana']['server']['static_root_path'] ||= '' unless new_resource.server_static_root_path.nil?
      variables['grafana']['server']['static_root_path'] << new_resource.server_static_root_path.to_s unless new_resource.server_static_root_path.nil?
      variables['grafana']['server']['enable_gzip'] ||= '' unless new_resource.server_enable_gzip.nil?
      variables['grafana']['server']['enable_gzip'] << new_resource.server_enable_gzip.to_s unless new_resource.server_enable_gzip.nil?
      variables['grafana']['server']['cert_file'] ||= '' unless new_resource.server_cert_file.nil?
      variables['grafana']['server']['cert_file'] << new_resource.server_cert_file.to_s unless new_resource.server_cert_file.nil?
      variables['grafana']['server']['cert_key'] ||= '' unless new_resource.server_cert_key.nil?
      variables['grafana']['server']['cert_key'] << new_resource.server_cert_key.to_s unless new_resource.server_cert_key.nil?

      variables['grafana']['database'] ||= {}
      variables['grafana']['database']['type'] ||= '' unless new_resource.database_type.nil?
      variables['grafana']['database']['type'] << new_resource.database_type.to_s unless new_resource.database_type.nil?
      variables['grafana']['database']['host'] ||= '' unless new_resource.database_host.nil?
      variables['grafana']['database']['host'] << new_resource.database_host.to_s unless new_resource.database_host.nil?
      variables['grafana']['database']['name'] ||= '' unless new_resource.database_name.nil?
      variables['grafana']['database']['name'] << new_resource.database_name.to_s unless new_resource.database_name.nil?
      variables['grafana']['database']['user'] ||= '' unless new_resource.database_user.nil?
      variables['grafana']['database']['user'] << new_resource.database_user.to_s unless new_resource.database_user.nil?
      variables['grafana']['database']['password'] ||= '' unless new_resource.database_password.nil?
      variables['grafana']['database']['password'] << new_resource.database_password.to_s unless new_resource.database_password.nil?
      variables['grafana']['database']['max_idle_conn'] ||= '' unless new_resource.database_max_idle_conn.nil?
      variables['grafana']['database']['max_idle_conn'] << new_resource.database_max_idle_conn.to_s unless new_resource.database_max_idle_conn.nil?
      variables['grafana']['database']['max_opem_conn'] ||= '' unless new_resource.database_max_opem_conn.nil?
      variables['grafana']['database']['max_opem_conn'] << new_resource.database_max_opem_conn.to_s unless new_resource.database_max_opem_conn.nil?
      variables['grafana']['database']['conn_max_lifetime'] ||= '' unless new_resource.database_conn_max_lifetime.nil?
      variables['grafana']['database']['conn_max_lifetime'] << new_resource.database_conn_max_lifetime.to_s unless new_resource.database_conn_max_lifetime.nil?
      variables['grafana']['database']['log_queries'] ||= '' unless new_resource.database_log_queries.nil?
      variables['grafana']['database']['log_queries'] << new_resource.database_log_queries.to_s unless new_resource.database_log_queries.nil?
      variables['grafana']['database']['ssl_mode'] ||= '' unless new_resource.database_ssl_mode.nil?
      variables['grafana']['database']['ssl_mode'] << new_resource.database_ssl_mode.to_s unless new_resource.database_ssl_mode.nil?
      variables['grafana']['database']['ca_cert_path'] ||= '' unless new_resource.database_ca_cert_path.nil?
      variables['grafana']['database']['ca_cert_path'] << new_resource.database_ca_cert_path.to_s unless new_resource.database_ca_cert_path.nil?
      variables['grafana']['database']['client_key_path'] ||= '' unless new_resource.database_client_key_path.nil?
      variables['grafana']['database']['client_key_path'] << new_resource.database_client_key_path.to_s unless new_resource.database_client_key_path.nil?
      variables['grafana']['database']['client_cert_path'] ||= '' unless new_resource.database_client_cert_path.nil?
      variables['grafana']['database']['client_cert_path'] << new_resource.database_client_cert_path.to_s unless new_resource.database_client_cert_path.nil?
      variables['grafana']['database']['server_cert_name'] ||= '' unless new_resource.database_server_cert_name.nil?
      variables['grafana']['database']['server_cert_name'] << new_resource.database_server_cert_name.to_s unless new_resource.database_server_cert_name.nil?
      variables['grafana']['database']['path'] ||= '' unless new_resource.database_path.nil?
      variables['grafana']['database']['path'] << new_resource.database_path.to_s unless new_resource.database_path.nil?

      variables['grafana']['session'] ||= {}
      variables['grafana']['session']['provider'] ||= '' unless new_resource.session_provider.nil?
      variables['grafana']['session']['provider'] << new_resource.session_provider.to_s unless new_resource.session_provider.nil?
      variables['grafana']['session']['provider_config'] ||= '' unless new_resource.session_provider_config.nil?
      variables['grafana']['session']['provider_config'] << new_resource.session_provider_config.to_s unless new_resource.session_provider_config.nil?
      variables['grafana']['session']['cookie_name'] ||= '' unless new_resource.session_cookie_name.nil?
      variables['grafana']['session']['cookie_name'] << new_resource.session_cookie_name.to_s unless new_resource.session_cookie_name.nil?
      variables['grafana']['session']['cookie_secure'] ||= '' unless new_resource.session_cookie_secure.nil?
      variables['grafana']['session']['cookie_secure'] << new_resource.session_cookie_secure.to_s unless new_resource.session_cookie_secure.nil?
      variables['grafana']['session']['session_life_time'] ||= '' unless new_resource.session_session_life_time.nil?
      variables['grafana']['session']['session_life_time'] << new_resource.session_session_life_time.to_s unless new_resource.session_session_life_time.nil?
      variables['grafana']['session']['gc_interval_time'] ||= '' unless new_resource.session_gc_interval_time.nil?
      variables['grafana']['session']['gc_interval_time'] << new_resource.session_gc_interval_time.to_s unless new_resource.session_gc_interval_time.nil?
      variables['grafana']['session']['conn_max_lifetime'] ||= '' unless new_resource.session_conn_max_lifetime.nil?
      variables['grafana']['session']['conn_max_lifetime'] << new_resource.session_conn_max_lifetime.to_s unless new_resource.session_conn_max_lifetime.nil?

      variables['grafana']['dataproxy'] ||= {}
      variables['grafana']['dataproxy']['logging'] ||= '' unless new_resource.dataproxy_logging.nil?
      variables['grafana']['dataproxy']['logging'] << new_resource.dataproxy_logging.to_s unless new_resource.dataproxy_logging.nil?

      variables['grafana']['security'] ||= {}
      variables['grafana']['security']['admin_user'] ||= '' unless new_resource.security_admin_user.nil?
      variables['grafana']['security']['admin_user'] << new_resource.security_admin_user.to_s unless new_resource.security_admin_user.nil?
      variables['grafana']['security']['admin_password'] ||= '' unless new_resource.security_admin_password.nil?
      variables['grafana']['security']['admin_password'] << new_resource.security_admin_password.to_s unless new_resource.security_admin_password.nil?
      variables['grafana']['security']['secret_key'] ||= '' unless new_resource.security_secret_key.nil?
      variables['grafana']['security']['secret_key'] << new_resource.security_secret_key.to_s unless new_resource.security_secret_key.nil?
      variables['grafana']['security']['login_remember_days'] ||= '' unless new_resource.security_login_remember_days.nil?
      variables['grafana']['security']['login_remember_days'] << new_resource.security_login_remember_days.to_s unless new_resource.security_login_remember_days.nil?
      variables['grafana']['security']['cookie_username'] ||= '' unless new_resource.security_cookie_username.nil?
      variables['grafana']['security']['cookie_username'] << new_resource.security_cookie_username.to_s unless new_resource.security_cookie_username.nil?
      variables['grafana']['security']['cookie_remember_name'] ||= '' unless new_resource.security_cookie_remember_name.nil?
      variables['grafana']['security']['cookie_remember_name'] << new_resource.security_cookie_remember_name.to_s unless new_resource.security_cookie_remember_name.nil?
      variables['grafana']['security']['disable_gravatar'] ||= '' unless new_resource.security_disable_gravatar.nil?
      variables['grafana']['security']['disable_gravatar'] << new_resource.security_disable_gravatar.to_s unless new_resource.security_disable_gravatar.nil?
      variables['grafana']['security']['data_source_proxy_whitelist'] ||= '' unless new_resource.security_data_source_proxy_whitelist.nil?
      variables['grafana']['security']['data_source_proxy_whitelist'] << new_resource.security_data_source_proxy_whitelist.to_s unless new_resource.security_data_source_proxy_whitelist.nil?
      variables['grafana']['security']['disable_brute_force_login_protection'] ||= '' unless new_resource.security_disable_brute_force_login_protection.nil?
      variables['grafana']['security']['disable_brute_force_login_protection'] << new_resource.security_disable_brute_force_login_protection.to_s unless new_resource.security_disable_brute_force_login_protection.nil?

      variables['grafana']['snapshots'] ||= {}
      variables['grafana']['snapshots']['external_enabled'] ||= '' unless new_resource.snapshots_external_enabled.nil?
      variables['grafana']['snapshots']['external_enabled'] << new_resource.snapshots_external_enabled.to_s unless new_resource.snapshots_external_enabled.nil?
      variables['grafana']['snapshots']['external_snapshot_url'] ||= '' unless new_resource.snapshots_external_snapshot_url.nil?
      variables['grafana']['snapshots']['external_snapshot_url'] << new_resource.snapshots_external_snapshot_url.to_s unless new_resource.snapshots_external_snapshot_url.nil?
      variables['grafana']['snapshots']['external_snapshot_name'] ||= '' unless new_resource.snapshots_external_snapshot_name.nil?
      variables['grafana']['snapshots']['external_snapshot_name'] << new_resource.snapshots_external_snapshot_name.to_s unless new_resource.snapshots_external_snapshot_name.nil?
      variables['grafana']['snapshots']['snapshot_remove_expired'] ||= '' unless new_resource.snapshots_snapshot_remove_expired.nil?
      variables['grafana']['snapshots']['snapshot_remove_expired'] << new_resource.snapshots_snapshot_remove_expired.to_s unless new_resource.snapshots_snapshot_remove_expired.nil?

      variables['grafana']['dashboards'] ||= {}
      variables['grafana']['dashboards']['versions_to_keep'] ||= '' unless new_resource.dashboards_versions_to_keep.nil?
      variables['grafana']['dashboards']['versions_to_keep'] << new_resource.dashboards_versions_to_keep.to_s unless new_resource.dashboards_versions_to_keep.nil?

      variables['grafana']['users'] ||= {}
      variables['grafana']['users']['allow_sign_up'] ||= '' unless new_resource.users_allow_sign_up.nil?
      variables['grafana']['users']['allow_sign_up'] << new_resource.users_allow_sign_up.to_s unless new_resource.users_allow_sign_up.nil?
      variables['grafana']['users']['allow_org_create'] ||= '' unless new_resource.users_allow_org_create.nil?
      variables['grafana']['users']['allow_org_create'] << new_resource.users_allow_org_create.to_s unless new_resource.users_allow_org_create.nil?
      variables['grafana']['users']['auto_assign_org'] ||= '' unless new_resource.users_auto_assign_org.nil?
      variables['grafana']['users']['auto_assign_org'] << new_resource.users_auto_assign_org.to_s unless new_resource.users_auto_assign_org.nil?
      variables['grafana']['users']['auto_assign_org_id'] ||= '' unless new_resource.users_auto_assign_org_id.nil?
      variables['grafana']['users']['auto_assign_org_id'] << new_resource.users_auto_assign_org_id.to_s unless new_resource.users_auto_assign_org_id.nil?
      variables['grafana']['users']['auto_assign_org_role'] ||= '' unless new_resource.users_auto_assign_org_role.nil?
      variables['grafana']['users']['auto_assign_org_role'] << new_resource.users_auto_assign_org_role.to_s unless new_resource.users_auto_assign_org_role.nil?
      variables['grafana']['users']['verify_email_enabled'] ||= '' unless new_resource.users_verify_email_enabled.nil?
      variables['grafana']['users']['verify_email_enabled'] << new_resource.users_verify_email_enabled.to_s unless new_resource.users_verify_email_enabled.nil?
      variables['grafana']['users']['login_hint'] ||= '' unless new_resource.users_login_hint.nil?
      variables['grafana']['users']['login_hint'] << new_resource.users_login_hint.to_s unless new_resource.users_login_hint.nil?
      variables['grafana']['users']['default_theme'] ||= '' unless new_resource.users_default_theme.nil?
      variables['grafana']['users']['default_theme'] << new_resource.users_default_theme.to_s unless new_resource.users_default_theme.nil?
      variables['grafana']['users']['external_manage_link_url'] ||= '' unless new_resource.users_external_manage_link_url.nil?
      variables['grafana']['users']['external_manage_link_url'] << new_resource.users_external_manage_link_url.to_s unless new_resource.users_external_manage_link_url.nil?
      variables['grafana']['users']['external_manage_link_name'] ||= '' unless new_resource.users_external_manage_link_name.nil?
      variables['grafana']['users']['external_manage_link_name'] << new_resource.users_external_manage_link_name.to_s unless new_resource.users_external_manage_link_name.nil?
      variables['grafana']['users']['external_manage_info'] ||= '' unless new_resource.users_external_manage_info.nil?
      variables['grafana']['users']['external_manage_info'] << new_resource.users_external_manage_info.to_s unless new_resource.users_external_manage_info.nil?
      variables['grafana']['users']['viewers_can_edit'] ||= '' unless new_resource.users_viewers_can_edit.nil?
      variables['grafana']['users']['viewers_can_edit'] << new_resource.users_viewers_can_edit.to_s unless new_resource.users_viewers_can_edit.nil?

      variables['grafana']['smtp'] ||= {}
      variables['grafana']['smtp']['enabled'] ||= '' unless new_resource.smtp_enabled.nil?
      variables['grafana']['smtp']['enabled'] << new_resource.smtp_enabled.to_s unless new_resource.smtp_enabled.nil?
      variables['grafana']['smtp']['host'] ||= '' unless new_resource.smtp_host.nil?
      variables['grafana']['smtp']['host'] << new_resource.smtp_host.to_s unless new_resource.smtp_host.nil?
      variables['grafana']['smtp']['user'] ||= '' unless new_resource.smtp_user.nil?
      variables['grafana']['smtp']['user'] << new_resource.smtp_user.to_s unless new_resource.smtp_user.nil?
      variables['grafana']['smtp']['password'] ||= '' unless new_resource.smtp_password.nil?
      variables['grafana']['smtp']['password'] << new_resource.smtp_password.to_s unless new_resource.smtp_password.nil?
      variables['grafana']['smtp']['cert_file'] ||= '' unless new_resource.smtp_cert_file.nil?
      variables['grafana']['smtp']['cert_file'] << new_resource.smtp_cert_file.to_s unless new_resource.smtp_cert_file.nil?
      variables['grafana']['smtp']['key_file'] ||= '' unless new_resource.smtp_key_file.nil?
      variables['grafana']['smtp']['key_file'] << new_resource.smtp_key_file.to_s unless new_resource.smtp_key_file.nil?
      variables['grafana']['smtp']['skip_verify'] ||= '' unless new_resource.smtp_skip_verify.nil?
      variables['grafana']['smtp']['skip_verify'] << new_resource.smtp_skip_verify.to_s unless new_resource.smtp_skip_verify.nil?
      variables['grafana']['smtp']['from_address'] ||= '' unless new_resource.smtp_from_address.nil?
      variables['grafana']['smtp']['from_address'] << new_resource.smtp_from_address.to_s unless new_resource.smtp_from_address.nil?
      variables['grafana']['smtp']['from_name'] ||= '' unless new_resource.smtp_from_name.nil?
      variables['grafana']['smtp']['from_name'] << new_resource.smtp_from_name.to_s unless new_resource.smtp_from_name.nil?
      variables['grafana']['smtp']['ehlo_identity'] ||= '' unless new_resource.smtp_ehlo_identity.nil?
      variables['grafana']['smtp']['ehlo_identity'] << new_resource.smtp_ehlo_identity.to_s unless new_resource.smtp_ehlo_identity.nil?

      variables['grafana']['emails'] ||= {}
      variables['grafana']['emails']['welcome_email_on_sign_up'] ||= '' unless new_resource.emails_welcome_email_on_sign_up.nil?
      variables['grafana']['emails']['welcome_email_on_sign_up'] << new_resource.emails_welcome_email_on_sign_up.to_s unless new_resource.emails_welcome_email_on_sign_up.nil?
      variables['grafana']['emails']['templates_pattern'] ||= '' unless new_resource.emails_templates_pattern.nil?
      variables['grafana']['emails']['templates_pattern'] << new_resource.emails_templates_pattern.to_s unless new_resource.emails_templates_pattern.nil?

      variables['grafana']['quota'] ||= {}
      variables['grafana']['quota']['enabled'] ||= '' unless new_resource.quota_enabled.nil?
      variables['grafana']['quota']['enabled'] << new_resource.quota_enabled.to_s unless new_resource.quota_enabled.nil?
      variables['grafana']['quota']['org_user'] ||= '' unless new_resource.quota_org_user.nil?
      variables['grafana']['quota']['org_user'] << new_resource.quota_org_user.to_s unless new_resource.quota_org_user.nil?
      variables['grafana']['quota']['org_dashboard'] ||= '' unless new_resource.quota_org_dashboard.nil?
      variables['grafana']['quota']['org_dashboard'] << new_resource.quota_org_dashboard.to_s unless new_resource.quota_org_dashboard.nil?
      variables['grafana']['quota']['org_data_source'] ||= '' unless new_resource.quota_org_data_source.nil?
      variables['grafana']['quota']['org_data_source'] << new_resource.quota_org_data_source.to_s unless new_resource.quota_org_data_source.nil?
      variables['grafana']['quota']['org_api_key'] ||= '' unless new_resource.quota_org_api_key.nil?
      variables['grafana']['quota']['org_api_key'] << new_resource.quota_org_api_key.to_s unless new_resource.quota_org_api_key.nil?
      variables['grafana']['quota']['user_org'] ||= '' unless new_resource.quota_user_org.nil?
      variables['grafana']['quota']['user_org'] << new_resource.quota_user_org.to_s unless new_resource.quota_user_org.nil?
      variables['grafana']['quota']['global_user'] ||= '' unless new_resource.quota_global_user.nil?
      variables['grafana']['quota']['global_user'] << new_resource.quota_global_user.to_s unless new_resource.quota_global_user.nil?
      variables['grafana']['quota']['global_org'] ||= '' unless new_resource.quota_global_org.nil?
      variables['grafana']['quota']['global_org'] << new_resource.quota_global_org.to_s unless new_resource.quota_global_org.nil?
      variables['grafana']['quota']['global_dashboard'] ||= '' unless new_resource.quota_global_dashboard.nil?
      variables['grafana']['quota']['global_dashboard'] << new_resource.quota_global_dashboard.to_s unless new_resource.quota_global_dashboard.nil?
      variables['grafana']['quota']['global_api_key'] ||= '' unless new_resource.quota_global_api_key.nil?
      variables['grafana']['quota']['global_api_key'] << new_resource.quota_global_api_key.to_s unless new_resource.quota_global_api_key.nil?
      variables['grafana']['quota']['global_session'] ||= '' unless new_resource.quota_global_session.nil?
      variables['grafana']['quota']['global_session'] << new_resource.quota_global_session.to_s unless new_resource.quota_global_session.nil?

      variables['grafana']['alerting'] ||= {}
      variables['grafana']['alerting']['enabled'] ||= '' unless new_resource.alerting_enabled.nil?
      variables['grafana']['alerting']['enabled'] << new_resource.alerting_enabled.to_s unless new_resource.alerting_enabled.nil?
      variables['grafana']['alerting']['execute_alerts'] ||= '' unless new_resource.alerting_execute_alerts.nil?
      variables['grafana']['alerting']['execute_alerts'] << new_resource.alerting_execute_alerts.to_s unless new_resource.alerting_execute_alerts.nil?
      variables['grafana']['alerting']['error_or_timeout'] ||= '' unless new_resource.alerting_error_or_timeout.nil?
      variables['grafana']['alerting']['error_or_timeout'] << new_resource.alerting_error_or_timeout.to_s unless new_resource.alerting_error_or_timeout.nil?
      variables['grafana']['alerting']['nodata_or_nullvalues'] ||= '' unless new_resource.alerting_nodata_or_nullvalues.nil?
      variables['grafana']['alerting']['nodata_or_nullvalues'] << new_resource.alerting_nodata_or_nullvalues.to_s unless new_resource.alerting_nodata_or_nullvalues.nil?
      variables['grafana']['alerting']['concurrent_render_limit'] ||= '' unless new_resource.alerting_concurrent_render_limit.nil?
      variables['grafana']['alerting']['concurrent_render_limit'] << new_resource.alerting_concurrent_render_limit.to_s unless new_resource.alerting_concurrent_render_limit.nil?

      variables['grafana']['metrics'] ||= {}
      variables['grafana']['metrics']['enabled'] ||= '' unless new_resource.metrics_enabled.nil?
      variables['grafana']['metrics']['enabled'] << new_resource.metrics_enabled.to_s unless new_resource.metrics_enabled.nil?
      variables['grafana']['metrics']['interval_seconds'] ||= '' unless new_resource.metrics_interval_seconds.nil?
      variables['grafana']['metrics']['interval_seconds'] << new_resource.metrics_interval_seconds.to_s unless new_resource.metrics_interval_seconds.nil?
      variables['grafana']['metrics']['basic_auth_username'] ||= '' unless new_resource.metrics_basic_auth_username.nil?
      variables['grafana']['metrics']['basic_auth_username'] << new_resource.metrics_basic_auth_username.to_s unless new_resource.metrics_basic_auth_username.nil?
      variables['grafana']['metrics']['basic_auth_password'] ||= '' unless new_resource.metrics_basic_auth_password.nil?
      variables['grafana']['metrics']['basic_auth_password'] << new_resource.metrics_basic_auth_password.to_s unless new_resource.metrics_basic_auth_password.nil?

      variables['grafana']['metrics_graphite'] ||= {}
      variables['grafana']['metrics_graphite']['address'] ||= '' unless new_resource.metrics_graphite_address.nil?
      variables['grafana']['metrics_graphite']['address'] << new_resource.metrics_graphite_address.to_s unless new_resource.metrics_graphite_address.nil?
      variables['grafana']['metrics_graphite']['prefix'] ||= '' unless new_resource.metrics_graphite_prefix.nil?
      variables['grafana']['metrics_graphite']['prefix'] << new_resource.metrics_graphite_prefix.to_s unless new_resource.metrics_graphite_prefix.nil?

      variables['grafana']['explore'] ||= {}
      variables['grafana']['explore']['enabled'] ||= '' unless new_resource.explore_enabled.nil?
      variables['grafana']['explore']['enabled'] << new_resource.explore_enabled.to_s unless new_resource.explore_enabled.nil?

      variables['grafana']['panels'] ||= {}
      variables['grafana']['panels']['enable_alpha'] ||= '' unless new_resource.panels_enable_alpha.nil?
      variables['grafana']['panels']['enable_alpha'] << new_resource.panels_enable_alpha.to_s unless new_resource.panels_enable_alpha.nil?

      variables['grafana']['log'] ||= {}
      variables['grafana']['log']['mode'] ||= '' unless new_resource.log_mode.nil?
      variables['grafana']['log']['mode'] << new_resource.log_mode.to_s unless new_resource.log_mode.nil?
      variables['grafana']['log']['level'] ||= '' unless new_resource.log_level.nil?
      variables['grafana']['log']['level'] << new_resource.log_level.to_s unless new_resource.log_level.nil?
      variables['grafana']['log']['filters'] ||= '' unless new_resource.log_filters.nil?
      variables['grafana']['log']['filters'] << new_resource.log_filters.to_s unless new_resource.log_filters.nil?

      variables['grafana']['log_console'] ||= {}
      variables['grafana']['log_console']['level'] ||= '' unless new_resource.log_console_level.nil?
      variables['grafana']['log_console']['level'] << new_resource.log_console_level.to_s unless new_resource.log_console_level.nil?
      variables['grafana']['log_console']['format'] ||= '' unless new_resource.log_console_format.nil?
      variables['grafana']['log_console']['format'] << new_resource.log_console_format.to_s unless new_resource.log_console_format.nil?

      variables['grafana']['log_file'] ||= {}
      variables['grafana']['log_file']['level'] ||= '' unless new_resource.log_file_level.nil?
      variables['grafana']['log_file']['level'] << new_resource.log_file_level.to_s unless new_resource.log_file_level.nil?
      variables['grafana']['log_file']['format'] ||= '' unless new_resource.log_file_format.nil?
      variables['grafana']['log_file']['format'] << new_resource.log_file_format.to_s unless new_resource.log_file_format.nil?
      variables['grafana']['log_file']['log_rotate'] ||= '' unless new_resource.log_file_log_rotate.nil?
      variables['grafana']['log_file']['log_rotate'] << new_resource.log_file_log_rotate.to_s unless new_resource.log_file_log_rotate.nil?
      variables['grafana']['log_file']['max_lines'] ||= '' unless new_resource.log_file_max_lines.nil?
      variables['grafana']['log_file']['max_lines'] << new_resource.log_file_max_lines.to_s unless new_resource.log_file_max_lines.nil?
      variables['grafana']['log_file']['max_size_shift'] ||= '' unless new_resource.log_file_max_size_shift.nil?
      variables['grafana']['log_file']['max_size_shift'] << new_resource.log_file_max_size_shift.to_s unless new_resource.log_file_max_size_shift.nil?
      variables['grafana']['log_file']['daily_rotate'] ||= '' unless new_resource.log_file_daily_rotate.nil?
      variables['grafana']['log_file']['daily_rotate'] << new_resource.log_file_daily_rotate.to_s unless new_resource.log_file_daily_rotate.nil?
      variables['grafana']['log_file']['max_days'] ||= '' unless new_resource.log_file_max_days.nil?
      variables['grafana']['log_file']['max_days'] << new_resource.log_file_max_days.to_s unless new_resource.log_file_max_days.nil?

      variables['grafana']['log_syslog'] ||= {}
      variables['grafana']['log_syslog']['level'] ||= '' unless new_resource.log_syslog_level.nil?
      variables['grafana']['log_syslog']['level'] << new_resource.log_syslog_level.to_s unless new_resource.log_syslog_level.nil?
      variables['grafana']['log_syslog']['format'] ||= '' unless new_resource.log_syslog_format.nil?
      variables['grafana']['log_syslog']['format'] << new_resource.log_syslog_format.to_s unless new_resource.log_syslog_format.nil?
      variables['grafana']['log_syslog']['network'] ||= '' unless new_resource.log_syslog_network.nil?
      variables['grafana']['log_syslog']['network'] << new_resource.log_syslog_network.to_s unless new_resource.log_syslog_network.nil?
      variables['grafana']['log_syslog']['address'] ||= '' unless new_resource.log_syslog_address.nil?
      variables['grafana']['log_syslog']['address'] << new_resource.log_syslog_address.to_s unless new_resource.log_syslog_address.nil?
      variables['grafana']['log_syslog']['facility'] ||= '' unless new_resource.log_syslog_facility.nil?
      variables['grafana']['log_syslog']['facility'] << new_resource.log_syslog_facility.to_s unless new_resource.log_syslog_facility.nil?
      variables['grafana']['log_syslog']['tag'] ||= '' unless new_resource.log_syslog_tag.nil?
      variables['grafana']['log_syslog']['tag'] << new_resource.log_syslog_tag.to_s unless new_resource.log_syslog_tag.nil?

      variables['grafana']['auth'] ||= {}
      variables['grafana']['auth']['disable_login_form'] ||= '' unless new_resource.auth_disable_login_form.nil?
      variables['grafana']['auth']['disable_login_form'] << new_resource.auth_disable_login_form.to_s unless new_resource.auth_disable_login_form.nil?
      variables['grafana']['auth']['disable_signout_menu'] ||= '' unless new_resource.auth_disable_signout_menu.nil?
      variables['grafana']['auth']['disable_signout_menu'] << new_resource.auth_disable_signout_menu.to_s unless new_resource.auth_disable_signout_menu.nil?
      variables['grafana']['auth']['signout_redirect_url'] ||= '' unless new_resource.auth_signout_redirect_url.nil?
      variables['grafana']['auth']['signout_redirect_url'] << new_resource.auth_signout_redirect_url.to_s unless new_resource.auth_signout_redirect_url.nil?
      variables['grafana']['auth']['oauth_auto_login'] ||= '' unless new_resource.auth_oauth_auto_login.nil?
      variables['grafana']['auth']['oauth_auto_login'] << new_resource.auth_oauth_auto_login.to_s unless new_resource.auth_oauth_auto_login.nil?

      variables['grafana']['auth_anonymous'] ||= {}
      variables['grafana']['auth_anonymous']['enabled'] ||= '' unless new_resource.auth_anonymous_enabled.nil?
      variables['grafana']['auth_anonymous']['enabled'] << new_resource.auth_anonymous_enabled.to_s unless new_resource.auth_anonymous_enabled.nil?
      variables['grafana']['auth_anonymous']['org_name'] ||= '' unless new_resource.auth_anonymous_org_name.nil?
      variables['grafana']['auth_anonymous']['org_name'] << new_resource.auth_anonymous_org_name.to_s unless new_resource.auth_anonymous_org_name.nil?
      variables['grafana']['auth_anonymous']['org_role'] ||= '' unless new_resource.auth_anonymous_org_role.nil?
      variables['grafana']['auth_anonymous']['org_role'] << new_resource.auth_anonymous_org_role.to_s unless new_resource.auth_anonymous_org_role.nil?

      variables['grafana']['auth_basic'] ||= {}
      variables['grafana']['auth_basic']['enabled'] ||= '' unless new_resource.auth_basic_enabled.nil?
      variables['grafana']['auth_basic']['enabled'] << new_resource.auth_basic_enabled.to_s unless new_resource.auth_basic_enabled.nil?

      variables['grafana']['auth_generic_oath'] ||= {}
      variables['grafana']['auth_generic_oath']['name'] ||= '' unless new_resource.auth_generic_oath_name.nil?
      variables['grafana']['auth_generic_oath']['name'] << new_resource.auth_generic_oath_name.to_s unless new_resource.auth_generic_oath_name.nil?
      variables['grafana']['auth_generic_oath']['enabled'] ||= '' unless new_resource.auth_generic_oath_enabled.nil?
      variables['grafana']['auth_generic_oath']['enabled'] << new_resource.auth_generic_oath_enabled.to_s unless new_resource.auth_generic_oath_enabled.nil?
      variables['grafana']['auth_generic_oath']['allow_sign_up'] ||= '' unless new_resource.auth_generic_oath_allow_sign_up.nil?
      variables['grafana']['auth_generic_oath']['allow_sign_up'] << new_resource.auth_generic_oath_allow_sign_up.to_s unless new_resource.auth_generic_oath_allow_sign_up.nil?
      variables['grafana']['auth_generic_oath']['client_id'] ||= '' unless new_resource.auth_generic_oath_client_id.nil?
      variables['grafana']['auth_generic_oath']['client_id'] << new_resource.auth_generic_oath_client_id.to_s unless new_resource.auth_generic_oath_client_id.nil?
      variables['grafana']['auth_generic_oath']['client_secret'] ||= '' unless new_resource.auth_generic_oath_client_secret.nil?
      variables['grafana']['auth_generic_oath']['client_secret'] << new_resource.auth_generic_oath_client_secret.to_s unless new_resource.auth_generic_oath_client_secret.nil?
      variables['grafana']['auth_generic_oath']['scopes'] ||= '' unless new_resource.auth_generic_oath_scopes.nil?
      variables['grafana']['auth_generic_oath']['scopes'] << new_resource.auth_generic_oath_scopes.to_s unless new_resource.auth_generic_oath_scopes.nil?
      variables['grafana']['auth_generic_oath']['email_attribute_name'] ||= '' unless new_resource.auth_generic_oath_email_attribute_name.nil?
      variables['grafana']['auth_generic_oath']['email_attribute_name'] << new_resource.auth_generic_oath_email_attribute_name.to_s unless new_resource.auth_generic_oath_email_attribute_name.nil?
      variables['grafana']['auth_generic_oath']['auth_url'] ||= '' unless new_resource.auth_generic_oath_auth_url.nil?
      variables['grafana']['auth_generic_oath']['auth_url'] << new_resource.auth_generic_oath_auth_url.to_s unless new_resource.auth_generic_oath_auth_url.nil?
      variables['grafana']['auth_generic_oath']['token_url'] ||= '' unless new_resource.auth_generic_oath_token_url.nil?
      variables['grafana']['auth_generic_oath']['token_url'] << new_resource.auth_generic_oath_token_url.to_s unless new_resource.auth_generic_oath_token_url.nil?
      variables['grafana']['auth_generic_oath']['api_url'] ||= '' unless new_resource.auth_generic_oath_api_url.nil?
      variables['grafana']['auth_generic_oath']['api_url'] << new_resource.auth_generic_oath_api_url.to_s unless new_resource.auth_generic_oath_api_url.nil?
      variables['grafana']['auth_generic_oath']['team_ids'] ||= '' unless new_resource.auth_generic_oath_team_ids.nil?
      variables['grafana']['auth_generic_oath']['team_ids'] << new_resource.auth_generic_oath_team_ids.to_s unless new_resource.auth_generic_oath_team_ids.nil?
      variables['grafana']['auth_generic_oath']['allowed_organizations'] ||= '' unless new_resource.auth_generic_oath_allowed_organizations.nil?
      variables['grafana']['auth_generic_oath']['allowed_organizations'] << new_resource.auth_generic_oath_allowed_organizations.to_s unless new_resource.auth_generic_oath_allowed_organizations.nil?
      variables['grafana']['auth_generic_oath']['tls_skip_verify_insecure'] ||= '' unless new_resource.auth_generic_oath_tls_skip_verify_insecure.nil?
      variables['grafana']['auth_generic_oath']['tls_skip_verify_insecure'] << new_resource.auth_generic_oath_tls_skip_verify_insecure.to_s unless new_resource.auth_generic_oath_tls_skip_verify_insecure.nil?
      variables['grafana']['auth_generic_oath']['tls_client_cert'] ||= '' unless new_resource.auth_generic_oath_tls_client_cert.nil?
      variables['grafana']['auth_generic_oath']['tls_client_cert'] << new_resource.auth_generic_oath_tls_client_cert.to_s unless new_resource.auth_generic_oath_tls_client_cert.nil?
      variables['grafana']['auth_generic_oath']['tls_client_key'] ||= '' unless new_resource.auth_generic_oath_tls_client_key.nil?
      variables['grafana']['auth_generic_oath']['tls_client_key'] << new_resource.auth_generic_oath_tls_client_key.to_s unless new_resource.auth_generic_oath_tls_client_key.nil?
      variables['grafana']['auth_generic_oath']['tls_client_ca'] ||= '' unless new_resource.auth_generic_oath_tls_client_ca.nil?
      variables['grafana']['auth_generic_oath']['tls_client_ca'] << new_resource.auth_generic_oath_tls_client_ca.to_s unless new_resource.auth_generic_oath_tls_client_ca.nil?
      variables['grafana']['auth_generic_oath']['send_client_credentials_via_post'] ||= '' unless new_resource.auth_generic_oath_send_client_credentials_via_post.nil?
      variables['grafana']['auth_generic_oath']['send_client_credentials_via_post'] << new_resource.auth_generic_oath_send_client_credentials_via_post.to_s unless new_resource.auth_generic_oath_send_client_credentials_via_post.nil?

      variables['grafana']['auth_github'] ||= {}
      variables['grafana']['auth_github']['enabled'] ||= '' unless new_resource.auth_github_enabled.nil?
      variables['grafana']['auth_github']['enabled'] << new_resource.auth_github_enabled.to_s unless new_resource.auth_github_enabled.nil?
      variables['grafana']['auth_github']['allow_sign_up'] ||= '' unless new_resource.auth_github_allow_sign_up.nil?
      variables['grafana']['auth_github']['allow_sign_up'] << new_resource.auth_github_allow_sign_up.to_s unless new_resource.auth_github_allow_sign_up.nil?
      variables['grafana']['auth_github']['client_id'] ||= '' unless new_resource.auth_github_client_id.nil?
      variables['grafana']['auth_github']['client_id'] << new_resource.auth_github_client_id.to_s unless new_resource.auth_github_client_id.nil?
      variables['grafana']['auth_github']['client_secret'] ||= '' unless new_resource.auth_github_client_secret.nil?
      variables['grafana']['auth_github']['client_secret'] << new_resource.auth_github_client_secret.to_s unless new_resource.auth_github_client_secret.nil?
      variables['grafana']['auth_github']['scopes'] ||= '' unless new_resource.auth_github_scopes.nil?
      variables['grafana']['auth_github']['scopes'] << new_resource.auth_github_scopes.to_s unless new_resource.auth_github_scopes.nil?
      variables['grafana']['auth_github']['auth_url,'] ||= '' unless new_resource.auth_github_auth_url.nil?
      variables['grafana']['auth_github']['auth_url,'] << new_resource.auth_github_auth_url.to_s unless new_resource.auth_github_auth_url.nil?
      variables['grafana']['auth_github']['token_url'] ||= '' unless new_resource.auth_github_token_url.nil?
      variables['grafana']['auth_github']['token_url'] << new_resource.auth_github_token_url.to_s unless new_resource.auth_github_token_url.nil?
      variables['grafana']['auth_github']['api_url'] ||= '' unless new_resource.auth_github_api_url.nil?
      variables['grafana']['auth_github']['api_url'] << new_resource.auth_github_api_url.to_s unless new_resource.auth_github_api_url.nil?
      variables['grafana']['auth_github']['team_ids'] ||= '' unless new_resource.auth_github_team_ids.nil?
      variables['grafana']['auth_github']['team_ids'] << new_resource.auth_github_team_ids.to_s unless new_resource.auth_github_team_ids.nil?
      variables['grafana']['auth_github']['allowed_organizations'] ||= '' unless new_resource.auth_github_allowed_organizations.nil?
      variables['grafana']['auth_github']['allowed_organizations'] << new_resource.auth_github_allowed_organizations.to_s unless new_resource.auth_github_allowed_organizations.nil?

      variables['grafana']['auth_gitlab'] ||= {}
      variables['grafana']['auth_gitlab']['enabled'] ||= '' unless new_resource.auth_gitlab_enabled.nil?
      variables['grafana']['auth_gitlab']['enabled'] << new_resource.auth_gitlab_enabled.to_s unless new_resource.auth_gitlab_enabled.nil?
      variables['grafana']['auth_gitlab']['allow_sign_up'] ||= '' unless new_resource.auth_gitlab_allow_sign_up.nil?
      variables['grafana']['auth_gitlab']['allow_sign_up'] << new_resource.auth_gitlab_allow_sign_up.to_s unless new_resource.auth_gitlab_allow_sign_up.nil?
      variables['grafana']['auth_gitlab']['client_id'] ||= '' unless new_resource.auth_gitlab_client_id.nil?
      variables['grafana']['auth_gitlab']['client_id'] << new_resource.auth_gitlab_client_id.to_s unless new_resource.auth_gitlab_client_id.nil?
      variables['grafana']['auth_gitlab']['client_secret'] ||= '' unless new_resource.auth_gitlab_client_secret.nil?
      variables['grafana']['auth_gitlab']['client_secret'] << new_resource.auth_gitlab_client_secret.to_s unless new_resource.auth_gitlab_client_secret.nil?
      variables['grafana']['auth_gitlab']['scopes'] ||= '' unless new_resource.auth_gitlab_scopes.nil?
      variables['grafana']['auth_gitlab']['scopes'] << new_resource.auth_gitlab_scopes.to_s unless new_resource.auth_gitlab_scopes.nil?
      variables['grafana']['auth_gitlab']['auth_url'] ||= '' unless new_resource.auth_gitlab_auth_url.nil?
      variables['grafana']['auth_gitlab']['auth_url'] << new_resource.auth_gitlab_auth_url.to_s unless new_resource.auth_gitlab_auth_url.nil?
      variables['grafana']['auth_gitlab']['token_url'] ||= '' unless new_resource.auth_gitlab_token_url.nil?
      variables['grafana']['auth_gitlab']['token_url'] << new_resource.auth_gitlab_token_url.to_s unless new_resource.auth_gitlab_token_url.nil?
      variables['grafana']['auth_gitlab']['api_url'] ||= '' unless new_resource.auth_gitlab_api_url.nil?
      variables['grafana']['auth_gitlab']['api_url'] << new_resource.auth_gitlab_api_url.to_s unless new_resource.auth_gitlab_api_url.nil?
      variables['grafana']['auth_gitlab']['allowed_groups'] ||= '' unless new_resource.auth_gitlab_allowed_groups.nil?
      variables['grafana']['auth_gitlab']['allowed_groups'] << new_resource.auth_gitlab_allowed_groups.to_s unless new_resource.auth_gitlab_allowed_groups.nil?

      variables['grafana']['auth_google'] ||= {}
      variables['grafana']['auth_google']['enabled'] ||= '' unless new_resource.auth_google_enabled.nil?
      variables['grafana']['auth_google']['enabled'] << new_resource.auth_google_enabled.to_s unless new_resource.auth_google_enabled.nil?
      variables['grafana']['auth_google']['allow_sign_up'] ||= '' unless new_resource.auth_google_allow_sign_up.nil?
      variables['grafana']['auth_google']['allow_sign_up'] << new_resource.auth_google_allow_sign_up.to_s unless new_resource.auth_google_allow_sign_up.nil?
      variables['grafana']['auth_google']['client_id'] ||= '' unless new_resource.auth_google_client_id.nil?
      variables['grafana']['auth_google']['client_id'] << new_resource.auth_google_client_id.to_s unless new_resource.auth_google_client_id.nil?
      variables['grafana']['auth_google']['client_secret'] ||= '' unless new_resource.auth_google_client_secret.nil?
      variables['grafana']['auth_google']['client_secret'] << new_resource.auth_google_client_secret.to_s unless new_resource.auth_google_client_secret.nil?
      variables['grafana']['auth_google']['scopes'] ||= '' unless new_resource.auth_google_scopes.nil?
      variables['grafana']['auth_google']['scopes'] << new_resource.auth_google_scopes.to_s unless new_resource.auth_google_scopes.nil?
      variables['grafana']['auth_google']['auth_url'] ||= '' unless new_resource.auth_google_auth_url.nil?
      variables['grafana']['auth_google']['auth_url'] << new_resource.auth_google_auth_url.to_s unless new_resource.auth_google_auth_url.nil?
      variables['grafana']['auth_google']['token_url'] ||= '' unless new_resource.auth_google_token_url.nil?
      variables['grafana']['auth_google']['token_url'] << new_resource.auth_google_token_url.to_s unless new_resource.auth_google_token_url.nil?
      variables['grafana']['auth_google']['api_url'] ||= '' unless new_resource.auth_google_api_url.nil?
      variables['grafana']['auth_google']['api_url'] << new_resource.auth_google_api_url.to_s unless new_resource.auth_google_api_url.nil?
      variables['grafana']['auth_google']['allowed_domains'] ||= '' unless new_resource.auth_google_allowed_domains.nil?
      variables['grafana']['auth_google']['allowed_domains'] << new_resource.auth_google_allowed_domains.to_s unless new_resource.auth_google_allowed_domains.nil?
      variables['grafana']['auth_google']['hosted_domain'] ||= '' unless new_resource.auth_google_hosted_domain.nil?
      variables['grafana']['auth_google']['hosted_domain'] << new_resource.auth_google_hosted_domain.to_s unless new_resource.auth_google_hosted_domain.nil?

      variables['grafana']['auth_grafanacom'] ||= {}
      variables['grafana']['auth_grafanacom']['enabled'] ||= '' unless new_resource.auth_grafanacom_enabled.nil?
      variables['grafana']['auth_grafanacom']['enabled'] << new_resource.auth_grafanacom_enabled.to_s unless new_resource.auth_grafanacom_enabled.nil?
      variables['grafana']['auth_grafanacom']['allow_sign_up'] ||= '' unless new_resource.auth_grafanacom_allow_sign_up.nil?
      variables['grafana']['auth_grafanacom']['allow_sign_up'] << new_resource.auth_grafanacom_allow_sign_up.to_s unless new_resource.auth_grafanacom_allow_sign_up.nil?
      variables['grafana']['auth_grafanacom']['client_id'] ||= '' unless new_resource.auth_grafanacom_client_id.nil?
      variables['grafana']['auth_grafanacom']['client_id'] << new_resource.auth_grafanacom_client_id.to_s unless new_resource.auth_grafanacom_client_id.nil?
      variables['grafana']['auth_grafanacom']['client_secret'] ||= '' unless new_resource.auth_grafanacom_client_secret.nil?
      variables['grafana']['auth_grafanacom']['client_secret'] << new_resource.auth_grafanacom_client_secret.to_s unless new_resource.auth_grafanacom_client_secret.nil?
      variables['grafana']['auth_grafanacom']['scopes'] ||= '' unless new_resource.auth_grafanacom_scopes.nil?
      variables['grafana']['auth_grafanacom']['scopes'] << new_resource.auth_grafanacom_scopes.to_s unless new_resource.auth_grafanacom_scopes.nil?
      variables['grafana']['auth_grafanacom']['allowed_organizations'] ||= '' unless new_resource.auth_grafanacom_allowed_organizations.nil?
      variables['grafana']['auth_grafanacom']['allowed_organizations'] << new_resource.auth_grafanacom_allowed_organizations.to_s unless new_resource.auth_grafanacom_allowed_organizations.nil?

      variables['grafana']['auth_grafananet'] ||= {}
      variables['grafana']['auth_grafananet']['enabled'] ||= '' unless new_resource.auth_grafananet_enabled.nil?
      variables['grafana']['auth_grafananet']['enabled'] << new_resource.auth_grafananet_enabled.to_s unless new_resource.auth_grafananet_enabled.nil?
      variables['grafana']['auth_grafananet']['allow_sign_up'] ||= '' unless new_resource.auth_grafananet_allow_sign_up.nil?
      variables['grafana']['auth_grafananet']['allow_sign_up'] << new_resource.auth_grafananet_allow_sign_up.to_s unless new_resource.auth_grafananet_allow_sign_up.nil?
      variables['grafana']['auth_grafananet']['client_id'] ||= '' unless new_resource.auth_grafananet_client_id.nil?
      variables['grafana']['auth_grafananet']['client_id'] << new_resource.auth_grafananet_client_id.to_s unless new_resource.auth_grafananet_client_id.nil?
      variables['grafana']['auth_grafananet']['client_secret'] ||= '' unless new_resource.auth_grafananet_client_secret.nil?
      variables['grafana']['auth_grafananet']['client_secret'] << new_resource.auth_grafananet_client_secret.to_s unless new_resource.auth_grafananet_client_secret.nil?
      variables['grafana']['auth_grafananet']['scopes'] ||= '' unless new_resource.auth_grafananet_scopes.nil?
      variables['grafana']['auth_grafananet']['scopes'] << new_resource.auth_grafananet_scopes.to_s unless new_resource.auth_grafananet_scopes.nil?
      variables['grafana']['auth_grafananet']['allowed_organizations'] ||= '' unless new_resource.auth_grafananet_allowed_organizations.nil?
      variables['grafana']['auth_grafananet']['allowed_organizations'] << new_resource.auth_grafananet_allowed_organizations.to_s unless new_resource.auth_grafananet_allowed_organizations.nil?

      variables['grafana']['auth_ldap'] ||= {}
      variables['grafana']['auth_ldap']['enabled'] ||= '' unless new_resource.auth_ldap_enabled.nil?
      variables['grafana']['auth_ldap']['enabled'] << new_resource.auth_ldap_enabled.to_s unless new_resource.auth_ldap_enabled.nil?
      variables['grafana']['auth_ldap']['config_file'] ||= '' unless new_resource.auth_ldap_config_file.nil?
      variables['grafana']['auth_ldap']['config_file'] << new_resource.auth_ldap_config_file.to_s unless new_resource.auth_ldap_config_file.nil?
      variables['grafana']['auth_ldap']['allow_sign_up'] ||= '' unless new_resource.auth_ldap_allow_sign_up.nil?
      variables['grafana']['auth_ldap']['allow_sign_up'] << new_resource.auth_ldap_allow_sign_up.to_s unless new_resource.auth_ldap_allow_sign_up.nil?

      variables['grafana']['auth_proxy'] ||= {}
      variables['grafana']['auth_proxy']['enabled'] ||= '' unless new_resource.auth_proxy_enabled.nil?
      variables['grafana']['auth_proxy']['enabled'] << new_resource.auth_proxy_enabled.to_s unless new_resource.auth_proxy_enabled.nil?
      variables['grafana']['auth_proxy']['header_name'] ||= '' unless new_resource.auth_proxy_header_name.nil?
      variables['grafana']['auth_proxy']['header_name'] << new_resource.auth_proxy_header_name.to_s unless new_resource.auth_proxy_header_name.nil?
      variables['grafana']['auth_proxy']['header_property'] ||= '' unless new_resource.auth_proxy_header_property.nil?
      variables['grafana']['auth_proxy']['header_property'] << new_resource.auth_proxy_header_property.to_s unless new_resource.auth_proxy_header_property.nil?
      variables['grafana']['auth_proxy']['auto_sign_up'] ||= '' unless new_resource.auth_proxy_auto_sign_up.nil?
      variables['grafana']['auth_proxy']['auto_sign_up'] << new_resource.auth_proxy_auto_sign_up.to_s unless new_resource.auth_proxy_auto_sign_up.nil?
      variables['grafana']['auth_proxy']['ldap_sync_ttl'] ||= '' unless new_resource.auth_proxy_ldap_sync_ttl.nil?
      variables['grafana']['auth_proxy']['ldap_sync_ttl'] << new_resource.auth_proxy_ldap_sync_ttl.to_s unless new_resource.auth_proxy_ldap_sync_ttl.nil?
      variables['grafana']['auth_proxy']['whitelist'] ||= '' unless new_resource.auth_proxy_whitelist.nil?
      variables['grafana']['auth_proxy']['whitelist'] << new_resource.auth_proxy_whitelist.to_s unless new_resource.auth_proxy_whitelist.nil?
      variables['grafana']['auth_proxy']['headers'] ||= '' unless new_resource.auth_proxy_headers.nil?
      variables['grafana']['auth_proxy']['headers'] << new_resource.auth_proxy_headers.to_s unless new_resource.auth_proxy_headers.nil?

      action :nothing
      delayed_action :create
    end
  end
end
