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
