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
property  :app_mode,                                              String,         default: 'production',        equal_to: ['production', 'development']
property  :paths_data,                                            String,         default: 'data'
property  :paths_temp_data_lifetime,                              String,         default: '24h'
property  :paths_logs,                                            String,         default: 'data/log'
property  :paths_plugins,                                         String,         default: 'data/plugins'
property  :paths_provisioning,                                    String,         default: 'conf/provisioning'
property  :server_protocol,                                       String,         default: 'http',              equal_to: ['http', 'https', 'socket']
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
property  :database_type,                                         String,         default: 'sqlite3',           equal_to: ['mysql', 'postgres', 'sqlite3']
property  :database_host,                                         String,         default: '127.0.0.1:3306'
property  :database_name,                                         String,         default: 'grafana'
property  :database_user,                                         String,         default: 'root'
property  :database_password,                                     String,         default: ''
property  :database_max_idle_conn,                                Integer,        default: 2
property  :database_max_opem_conn,                                Integer,        default: 0
property  :database_conn_max_lifetime,                            Integer,        default: 14400
property  :database_log_queries,                                  [true, false],  default: false
property  :database_ssl_mode,                                     String,         default: 'disable',           equal_to: ['disable', 'require', 'verify-full', 'true', 'false', 'skip-verify']
property  :database_ca_cert_path,                                 String,         default: ''
property  :database_client_key_path,                              String,         default: ''
property  :database_client_cert_path,                             String,         default: ''
property  :database_server_cert_name,                             String,         default: ''
property  :database_path,                                         String,         default: 'grafana.db'
property  :session_provider,                                      String,         default: 'file',              equal_to: ['memory', 'file', 'redis', 'mysql', 'postgres', 'memcache']
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
property  :snapshots_external_snapshot_url,                       String,         default: ''
property  :snapshots_external_snapshot_name,                      String,         default: ''
property  :snapshots_snapshot_remove_expired,                     [true, false],  default: true
property  :dashboards_versions_to_keep,                           Integer,        default: 20
property  :users_allow_sign_up,                                   [true, false],  default: false
property  :users_allow_org_create,                                [true, false],  default: false
property  :users_auto_assign_org,                                 [true, false],  default: true
property  :users_auto_assign_org_id,                              Integer,        default: 1
property  :users_auto_assign_org_role,                            String,         default: 'Viewer'
property  :users_verify_email_enabled,                            [true, false],  default: false
property  :users_login_hint,                                      String,         default: 'email or username'
property  :users_default_theme,                                   String,         default: 'dark',              equal_to: ['dark', 'light']
property  :users_external_manage_link_url,                        String,         default: ''
property  :users_external_manage_link_name,                       String,         default: ''
property  :users_external_manage_info,                            String,         default: ''
property  :users_viewers_can_edit,                                [true, false],  default: false
property  :users_disable_login_form,                              [true, false],  default: false
property  :users_disable_signout_menu,                            [true, false],  default: false
property  :users_signout_redirect_url ,                           String,         default: ''
property  :users_oauth_auto_login ,                               [true, false],  default: false
property  :auth_anonymous_enabled,                                [true, false],  default: false
property  :auth_anonymous_org_name,                               String,         default: 'Main Org.'
property  :auth_anonymous_org_role,                               String,         default: 'Viewer'
property  :auth_github_enabled,                                   [true, false],  default: false
property  :auth_github_allow_sign_up,                             [true, false],  default: true
property  :auth_github_client_id,                                 String,         default: ''
property  :auth_github_client_secret,                             String,         default: ''
property  :auth_github_scopes,                                    String,         default: ''
property  :auth_github_auth_url,,                                 String,         default: 'https://github.com/login/oauth/authorize'
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
property  :auth_google_client_id ,                                String,         default: ''
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
property  :auth_grafananet_scopes ,                               String,         default: 'user:email'
property  :auth_grafananet_allowed_organizations,                 String,         default: ''
property  :auth_grafanacom_enabled,                               [true, false],  default: false
property  :auth_grafanacom_allow_sign_up,                         [true, false],  default: true
property  :auth_grafanacom_client_id,                             String,         default: ''
property  :auth_grafanacom_client_secret,                         String,         default: ''
property  :auth_grafanacom_scopes ,                               String,         default: 'user:email'
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
property  :auth_basic,                                            [true, false],  default: true
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
property  :smtp_enabled,                                           [true, false],  default: false
property  :smtp_host,                                              String,         default: 'localhost:25'
property  :smtp_user,                                              String,         default: ''
property  :smtp_password,                                          String,         default: ''
property  :smtp_cert_file,                                         String,         default: ''
property  :smtp_key_file,                                          String,         default: ''
property  :smtp_skip_verify,                                       [true, false],  default: false
property  :smtp_from_address,                                      String,         default: "admin@grafana.#{node['hostname']}"
property  :smtp_from_name,                                         String,         default: 'Grafana'
property  :smtp_ehlo_identity,                                     String,         default: ''
property  :emails_welcome_email_on_sign_up,                        [true, false],  default: false
property  :emails_templates_pattern,                               String,         default: 'emails/*.html'
property  :log_mode,                                               String,         default: 'console file'
property  :log_level,                                              String,         default: 'info'
property  :log_filters,                                            String,         default: ''
property  :log_console_level,                                      String,         default: ''
property  :log_console_format,                                     String,         default: 'console'
property  :log_file_level,                                         String,         default: ''
property  :log_file_format,                                        String,         default: 'text'
property  :log_file_log_rotate,                                    [true, false],  default: true
property  :log_file_max_lines,                                     Integer,        default: 1000000
property  :log_file_max_size_shift,                                Integer,        default: 28
property  :log_file_daily_rotate,                                  [true, false],  default: true
property  :log_file_max_days,                                      Integer,        default: 7
property  :log_syslog_level,                                       String,         default: ''
property  :log_syslog_format,                                      String,         default: 'text'
property  :log_syslog_network,                                     String,         default: ''
property  :log_syslog_address,                                     String,         default: ''
property  :log_syslog_facility,                                    String,         default: ''
property  :log_syslog_tag,                                         String,         default: ''
property  :quota_enabled,                                          [true, false],  default: false
property  :quota_org_user,                                         Integer,        default: 10
property  :quota_org_dashboard,                                    Integer,        default: 100
property  :quota_org_data_source,                                  Integer,        default: 10
property  :quota_org_api_key,                                      Integer,        default: 10
property  :quota_user_org,                                         Integer,        default: 10
property  :quota_global_user,                                      Integer,        default: -1
property  :quota_global_org,                                       Integer,        default: -1
property  :quota_global_dashboard,                                 Integer,        default: -1
property  :quota_global_api_key,                                   Integer,        default: -1
property  :quota_global_session,                                   Integer,        default: -1
property  :alerting_enabled,                                       [true, false],  default: true
property  :alerting_execute_alerts,                                [true, false],  default: true
property  :alerting_error_or_timeout,                              String,         default: 'alerting'
property  :alerting_nodata_or_nullvalues,                          String,         default: 'no_data'
property  :alerting_concurrent_render_limit,                       Integer,        5
property  :explore_enabled,                                        [true, false],  default: false
property  :metrics_enabled,                                        [true, false],  default: true
property  :metrics_interval_seconds,                               Integer,        default: 10
property  :metrics_basic_auth_username,                            String,         default: ''
property  :metrics_basic_auth_password,                            String,         default: ''
property  :metrics_graphite_address,                               String,         default: ''
property  :metrics_graphite_prefix,                                String,         default: 'prod.grafana.%(instance_name)s.'
property  :panels_enable_alpha,                                    [true, false],  default: false
property  :enterprise_license_path,                                String,         default: ''

property  :env_directory,       String, default: '/etc/default'
property  :owner,               String, default: 'grafana'
property  :group,               String, default: 'grafana'
property  :restart_on_upgrade,  String, default: 'false'
property  :conf_directory,      String, default: '/etc/grafana'
property  :config_file,         String, default: lazy { ::File.join(conf_directory, 'grafana.ini') }

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
      variables['global'] ||= {}

      variables['global']['instance_name'] ||= '' unless new_resource.instance_name.nil?
      variables['global']['instance_name'] << new_resource.instance_name unless new_resource.instance_name.nil?
      variables['global']['app_mode'] ||= '' unless new_resource.app_mode.nil?
      variables['global']['app_mode'].<< new_resource.app_mode unless new_resource.app_mode.nil?

      action :nothing
      delayed_action :create
    end
  end
end
