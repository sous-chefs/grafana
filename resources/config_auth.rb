# Cookbook:: grafana
# Resource:: config_auth
#
# Copyright:: 2018, Sous Chefs
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

property  :instance_name,                                  String,         name_property: true
property  :login_cookie_name,                              String,         required: false
property  :disable_login_form,                             [true, false],  default: false
property  :disable_signout_menu,                           [true, false],  default: false
property  :signout_redirect_url,                           String,         default: ''
property  :oauth_auto_login,                               [true, false],  default: false
property  :login_maximum_lifetime_days,                    Integer,        required: false
property  :anonymous_enabled,                              [true, false],  default: false
property  :anonymous_org_name,                             String,         default: 'Main Org.'
property  :anonymous_org_role,                             String,         default: 'Viewer'
property  :github_enabled,                                 [true, false],  default: false
property  :github_allow_sign_up,                           [true, false],  default: true
property  :github_client_id,                               String,         default: ''
property  :github_client_secret,                           String,         default: ''
property  :github_scopes,                                  String,         default: ''
property  :github_auth_url,                                String,         default: 'https://github.com/login/oauth/authorize'
property  :github_token_url,                               String,         default: 'https://github.com/login/oauth/access_token'
property  :github_api_url,                                 String,         default: 'https://api.github.com/user'
property  :github_team_ids,                                String,         default: ''
property  :github_allowed_organizations,                   String,         default: ''
property  :gitlab_enabled,                                 [true, false],  default: false
property  :gitlab_allow_sign_up,                           [true, false],  default: true
property  :gitlab_client_id,                               String,         default: ''
property  :gitlab_client_secret,                           String,         default: ''
property  :gitlab_scopes,                                  String,         default: ''
property  :gitlab_auth_url,                                String,         default: 'https://gitlab.com/oauth/authorize'
property  :gitlab_token_url,                               String,         default: 'https://gitlab.com/oauth/token'
property  :gitlab_api_url,                                 String,         default: 'https://gitlab.com/api/v4'
property  :gitlab_allowed_groups,                          String,         default: ''
property  :google_enabled,                                 [true, false],  default: false
property  :google_allow_sign_up,                           [true, false],  default: true
property  :google_client_id,                               String,         default: ''
property  :google_client_secret,                           String,         default: ''
property  :google_scopes,                                  String,         default: 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
property  :google_auth_url,                                String,         default: 'https://accounts.google.com/o/oauth2/auth'
property  :google_token_url,                               String,         default: 'https://accounts.google.com/o/oauth2/token'
property  :google_api_url,                                 String,         default: 'https://www.googleapis.com/oauth2/v1/userinfo'
property  :google_allowed_domains,                         String,         default: ''
property  :google_hosted_domain,                           String,         default: ''
property  :grafananet_enabled,                             [true, false],  default: false
property  :grafananet_allow_sign_up,                       [true, false],  default: true
property  :grafananet_client_id,                           String,         default: ''
property  :grafananet_client_secret,                       String,         default: ''
property  :grafananet_scopes,                              String,         default: 'user:email'
property  :grafananet_allowed_organizations,               String,         default: ''
property  :grafanacom_enabled,                             [true, false],  default: false
property  :grafanacom_allow_sign_up,                       [true, false],  default: true
property  :grafanacom_client_id,                           String,         default: ''
property  :grafanacom_client_secret,                       String,         default: ''
property  :grafanacom_scopes,                              String,         default: 'user:email'
property  :grafanacom_allowed_organizations,               String,         default: ''
property  :generic_oauth_name,                             String,         default: 'OAuth'
property  :generic_oauth_enabled,                          [true, false],  default: false
property  :generic_oauth_allow_sign_up,                    [true, false],  default: true
property  :generic_oauth_client_id,                        String,         default: ''
property  :generic_oauth_client_secret,                    String,         default: ''
property  :generic_oauth_scopes,                           String,         default: 'user:email'
property  :generic_oauth_email_attribute_name,             String,         default: 'email:primary'
property  :generic_oauth_auth_url,                         String,         default: ''
property  :generic_oauth_token_url,                        String,         default: ''
property  :generic_oauth_api_url,                          String,         default: ''
property  :generic_oauth_team_ids,                         String,         default: ''
property  :generic_oauth_allowed_organizations,            String,         default: ''
property  :generic_oauth_role_attribute_path,              String,         default: ''
property  :generic_oauth_tls_skip_verify_insecure,         [true, false],  default: false
property  :generic_oauth_tls_client_cert,                  String,         default: ''
property  :generic_oauth_tls_client_key,                   String,         default: ''
property  :generic_oauth_tls_client_ca,                    String,         default: ''
property  :generic_oauth_send_client_credentials_via_post, [true, false],  default: false
property  :basic_enabled,                                  [true, false],  default: true
property  :proxy_enabled,                                  [true, false],  default: false
property  :proxy_header_name,                              String,         default: 'X-WEBAUTH-USER'
property  :proxy_header_property,                          String,         default: 'username'
property  :proxy_auto_sign_up,                             [true, false],  default: true
property  :proxy_ldap_sync_ttl,                            Integer,        default: 60
property  :proxy_whitelist,                                String,         default: ''
property  :proxy_headers,                                  String,         default: ''
property  :ldap_enabled,                                   [true, false],  default: false
property  :ldap_config_file,                               String,         default: '/etc/grafana/ldap.toml'
property  :ldap_allow_sign_up,                             [true, false],  default: true

action :install do
  login_cookie_name = new_resource.login_cookie_name || GrafanaCookbook::CookieHelper.cookie_name
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['login_cookie_name'] ||= '' unless login_cookie_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['login_cookie_name'] << login_cookie_name.to_s unless login_cookie_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['disable_login_form'] ||= '' unless new_resource.disable_login_form.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['disable_login_form'] << new_resource.disable_login_form.to_s unless new_resource.disable_login_form.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['disable_signout_menu'] ||= '' unless new_resource.disable_signout_menu.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['disable_signout_menu'] << new_resource.disable_signout_menu.to_s unless new_resource.disable_signout_menu.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['signout_redirect_url'] ||= '' unless new_resource.signout_redirect_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['signout_redirect_url'] << new_resource.signout_redirect_url.to_s unless new_resource.signout_redirect_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['oauth_auto_login'] ||= '' unless new_resource.oauth_auto_login.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['oauth_auto_login'] << new_resource.oauth_auto_login.to_s unless new_resource.oauth_auto_login.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['login_maximum_lifetime_days'] ||= '' unless new_resource.login_maximum_lifetime_days.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth']['login_maximum_lifetime_days'] << new_resource.login_maximum_lifetime_days.to_s unless new_resource.login_maximum_lifetime_days.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous']['enabled'] ||= '' unless new_resource.anonymous_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous']['enabled'] << new_resource.anonymous_enabled.to_s unless new_resource.anonymous_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous']['org_name'] ||= '' unless new_resource.anonymous_org_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous']['org_name'] << new_resource.anonymous_org_name.to_s unless new_resource.anonymous_org_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous']['org_role'] ||= '' unless new_resource.anonymous_org_role.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_anonymous']['org_role'] << new_resource.anonymous_org_role.to_s unless new_resource.anonymous_org_role.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_basic'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_basic']['enabled'] ||= '' unless new_resource.basic_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_basic']['enabled'] << new_resource.basic_enabled.to_s unless new_resource.basic_enabled.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['name'] ||= '' unless new_resource.generic_oauth_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['name'] << new_resource.generic_oauth_name.to_s unless new_resource.generic_oauth_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['enabled'] ||= '' unless new_resource.generic_oauth_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['enabled'] << new_resource.generic_oauth_enabled.to_s unless new_resource.generic_oauth_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['allow_sign_up'] ||= '' unless new_resource.generic_oauth_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['allow_sign_up'] << new_resource.generic_oauth_allow_sign_up.to_s unless new_resource.generic_oauth_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['client_id'] ||= '' unless new_resource.generic_oauth_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['client_id'] << new_resource.generic_oauth_client_id.to_s unless new_resource.generic_oauth_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['client_secret'] ||= '' unless new_resource.generic_oauth_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['client_secret'] << new_resource.generic_oauth_client_secret.to_s unless new_resource.generic_oauth_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['scopes'] ||= '' unless new_resource.generic_oauth_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['scopes'] << new_resource.generic_oauth_scopes.to_s unless new_resource.generic_oauth_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['email_attribute_name'] ||= '' unless new_resource.generic_oauth_email_attribute_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['email_attribute_name'] << new_resource.generic_oauth_email_attribute_name.to_s unless new_resource.generic_oauth_email_attribute_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['auth_url'] ||= '' unless new_resource.generic_oauth_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['auth_url'] << new_resource.generic_oauth_auth_url.to_s unless new_resource.generic_oauth_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['token_url'] ||= '' unless new_resource.generic_oauth_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['token_url'] << new_resource.generic_oauth_token_url.to_s unless new_resource.generic_oauth_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['api_url'] ||= '' unless new_resource.generic_oauth_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['api_url'] << new_resource.generic_oauth_api_url.to_s unless new_resource.generic_oauth_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['team_ids'] ||= '' unless new_resource.generic_oauth_team_ids.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['team_ids'] << new_resource.generic_oauth_team_ids.to_s unless new_resource.generic_oauth_team_ids.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['allowed_organizations'] ||= '' unless new_resource.generic_oauth_allowed_organizations.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['allowed_organizations'] << new_resource.generic_oauth_allowed_organizations.to_s unless new_resource.generic_oauth_allowed_organizations.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_skip_verify_insecure'] ||= '' unless new_resource.generic_oauth_tls_skip_verify_insecure.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_skip_verify_insecure'] << new_resource.generic_oauth_tls_skip_verify_insecure.to_s unless new_resource.generic_oauth_tls_skip_verify_insecure.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_client_cert'] ||= '' unless new_resource.generic_oauth_tls_client_cert.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_client_cert'] << new_resource.generic_oauth_tls_client_cert.to_s unless new_resource.generic_oauth_tls_client_cert.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_client_key'] ||= '' unless new_resource.generic_oauth_tls_client_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_client_key'] << new_resource.generic_oauth_tls_client_key.to_s unless new_resource.generic_oauth_tls_client_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_client_ca'] ||= '' unless new_resource.generic_oauth_tls_client_ca.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['tls_client_ca'] << new_resource.generic_oauth_tls_client_ca.to_s unless new_resource.generic_oauth_tls_client_ca.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['send_client_credentials_via_post'] ||= '' unless new_resource.generic_oauth_send_client_credentials_via_post.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['send_client_credentials_via_post'] << new_resource.generic_oauth_send_client_credentials_via_post.to_s unless new_resource.generic_oauth_send_client_credentials_via_post.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['role_attribute_path'] ||= '' unless new_resource.generic_oauth_role_attribute_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_generic_oauth']['role_attribute_path'] << new_resource.generic_oauth_role_attribute_path.to_s unless new_resource.generic_oauth_role_attribute_path.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['enabled'] ||= '' unless new_resource.github_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['enabled'] << new_resource.github_enabled.to_s unless new_resource.github_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['allow_sign_up'] ||= '' unless new_resource.github_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['allow_sign_up'] << new_resource.github_allow_sign_up.to_s unless new_resource.github_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['client_id'] ||= '' unless new_resource.github_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['client_id'] << new_resource.github_client_id.to_s unless new_resource.github_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['client_secret'] ||= '' unless new_resource.github_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['client_secret'] << new_resource.github_client_secret.to_s unless new_resource.github_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['scopes'] ||= '' unless new_resource.github_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['scopes'] << new_resource.github_scopes.to_s unless new_resource.github_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['auth_url,'] ||= '' unless new_resource.github_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['auth_url,'] << new_resource.github_auth_url.to_s unless new_resource.github_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['token_url'] ||= '' unless new_resource.github_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['token_url'] << new_resource.github_token_url.to_s unless new_resource.github_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['api_url'] ||= '' unless new_resource.github_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['api_url'] << new_resource.github_api_url.to_s unless new_resource.github_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['team_ids'] ||= '' unless new_resource.github_team_ids.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['team_ids'] << new_resource.github_team_ids.to_s unless new_resource.github_team_ids.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['allowed_organizations'] ||= '' unless new_resource.github_allowed_organizations.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_github']['allowed_organizations'] << new_resource.github_allowed_organizations.to_s unless new_resource.github_allowed_organizations.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['enabled'] ||= '' unless new_resource.gitlab_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['enabled'] << new_resource.gitlab_enabled.to_s unless new_resource.gitlab_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['allow_sign_up'] ||= '' unless new_resource.gitlab_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['allow_sign_up'] << new_resource.gitlab_allow_sign_up.to_s unless new_resource.gitlab_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['client_id'] ||= '' unless new_resource.gitlab_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['client_id'] << new_resource.gitlab_client_id.to_s unless new_resource.gitlab_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['client_secret'] ||= '' unless new_resource.gitlab_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['client_secret'] << new_resource.gitlab_client_secret.to_s unless new_resource.gitlab_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['scopes'] ||= '' unless new_resource.gitlab_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['scopes'] << new_resource.gitlab_scopes.to_s unless new_resource.gitlab_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['auth_url'] ||= '' unless new_resource.gitlab_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['auth_url'] << new_resource.gitlab_auth_url.to_s unless new_resource.gitlab_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['token_url'] ||= '' unless new_resource.gitlab_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['token_url'] << new_resource.gitlab_token_url.to_s unless new_resource.gitlab_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['api_url'] ||= '' unless new_resource.gitlab_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['api_url'] << new_resource.gitlab_api_url.to_s unless new_resource.gitlab_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['allowed_groups'] ||= '' unless new_resource.gitlab_allowed_groups.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_gitlab']['allowed_groups'] << new_resource.gitlab_allowed_groups.to_s unless new_resource.gitlab_allowed_groups.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['enabled'] ||= '' unless new_resource.google_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['enabled'] << new_resource.google_enabled.to_s unless new_resource.google_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['allow_sign_up'] ||= '' unless new_resource.google_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['allow_sign_up'] << new_resource.google_allow_sign_up.to_s unless new_resource.google_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['client_id'] ||= '' unless new_resource.google_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['client_id'] << new_resource.google_client_id.to_s unless new_resource.google_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['client_secret'] ||= '' unless new_resource.google_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['client_secret'] << new_resource.google_client_secret.to_s unless new_resource.google_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['scopes'] ||= '' unless new_resource.google_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['scopes'] << new_resource.google_scopes.to_s unless new_resource.google_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['auth_url'] ||= '' unless new_resource.google_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['auth_url'] << new_resource.google_auth_url.to_s unless new_resource.google_auth_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['token_url'] ||= '' unless new_resource.google_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['token_url'] << new_resource.google_token_url.to_s unless new_resource.google_token_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['api_url'] ||= '' unless new_resource.google_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['api_url'] << new_resource.google_api_url.to_s unless new_resource.google_api_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['allowed_domains'] ||= '' unless new_resource.google_allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['allowed_domains'] << new_resource.google_allowed_domains.to_s unless new_resource.google_allowed_domains.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['hosted_domain'] ||= '' unless new_resource.google_hosted_domain.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_google']['hosted_domain'] << new_resource.google_hosted_domain.to_s unless new_resource.google_hosted_domain.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['enabled'] ||= '' unless new_resource.grafanacom_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['enabled'] << new_resource.grafanacom_enabled.to_s unless new_resource.grafanacom_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['allow_sign_up'] ||= '' unless new_resource.grafanacom_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['allow_sign_up'] << new_resource.grafanacom_allow_sign_up.to_s unless new_resource.grafanacom_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['client_id'] ||= '' unless new_resource.grafanacom_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['client_id'] << new_resource.grafanacom_client_id.to_s unless new_resource.grafanacom_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['client_secret'] ||= '' unless new_resource.grafanacom_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['client_secret'] << new_resource.grafanacom_client_secret.to_s unless new_resource.grafanacom_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['scopes'] ||= '' unless new_resource.grafanacom_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['scopes'] << new_resource.grafanacom_scopes.to_s unless new_resource.grafanacom_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['allowed_organizations'] ||= '' unless new_resource.grafanacom_allowed_organizations.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafanacom']['allowed_organizations'] << new_resource.grafanacom_allowed_organizations.to_s unless new_resource.grafanacom_allowed_organizations.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['enabled'] ||= '' unless new_resource.grafananet_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['enabled'] << new_resource.grafananet_enabled.to_s unless new_resource.grafananet_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['allow_sign_up'] ||= '' unless new_resource.grafananet_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['allow_sign_up'] << new_resource.grafananet_allow_sign_up.to_s unless new_resource.grafananet_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['client_id'] ||= '' unless new_resource.grafananet_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['client_id'] << new_resource.grafananet_client_id.to_s unless new_resource.grafananet_client_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['client_secret'] ||= '' unless new_resource.grafananet_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['client_secret'] << new_resource.grafananet_client_secret.to_s unless new_resource.grafananet_client_secret.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['scopes'] ||= '' unless new_resource.grafananet_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['scopes'] << new_resource.grafananet_scopes.to_s unless new_resource.grafananet_scopes.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['allowed_organizations'] ||= '' unless new_resource.grafananet_allowed_organizations.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_grafananet']['allowed_organizations'] << new_resource.grafananet_allowed_organizations.to_s unless new_resource.grafananet_allowed_organizations.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap']['enabled'] ||= '' unless new_resource.ldap_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap']['enabled'] << new_resource.ldap_enabled.to_s unless new_resource.ldap_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap']['config_file'] ||= '' unless new_resource.ldap_config_file.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap']['config_file'] << new_resource.ldap_config_file.to_s unless new_resource.ldap_config_file.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap']['allow_sign_up'] ||= '' unless new_resource.ldap_allow_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_ldap']['allow_sign_up'] << new_resource.ldap_allow_sign_up.to_s unless new_resource.ldap_allow_sign_up.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['enabled'] ||= '' unless new_resource.proxy_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['enabled'] << new_resource.proxy_enabled.to_s unless new_resource.proxy_enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['header_name'] ||= '' unless new_resource.proxy_header_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['header_name'] << new_resource.proxy_header_name.to_s unless new_resource.proxy_header_name.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['header_property'] ||= '' unless new_resource.proxy_header_property.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['header_property'] << new_resource.proxy_header_property.to_s unless new_resource.proxy_header_property.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['auto_sign_up'] ||= '' unless new_resource.proxy_auto_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['auto_sign_up'] << new_resource.proxy_auto_sign_up.to_s unless new_resource.proxy_auto_sign_up.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['ldap_sync_ttl'] ||= '' unless new_resource.proxy_ldap_sync_ttl.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['ldap_sync_ttl'] << new_resource.proxy_ldap_sync_ttl.to_s unless new_resource.proxy_ldap_sync_ttl.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['whitelist'] ||= '' unless new_resource.proxy_whitelist.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['whitelist'] << new_resource.proxy_whitelist.to_s unless new_resource.proxy_whitelist.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['headers'] ||= '' unless new_resource.proxy_headers.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['auth_proxy']['headers'] << new_resource.proxy_headers.to_s unless new_resource.proxy_headers.nil?
end
