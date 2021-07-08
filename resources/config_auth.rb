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

unified_mode true

use 'partial/_config_file'

property  :instance_name,                                  String,         name_property: true
property  :login_cookie_name,                              String,         default: lazy { GrafanaCookbook::CookieHelper.cookie_name }
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

action_class do
  include GrafanaCookbook::ConfigHelper

  RESOURCE_PROPERTIES = {
    'auth' => %i(login_cookie_name disable_login_form disable_signout_menu signout_redirect_url oauth_auto_login login_maximum_lifetime_days),
    'auth_anonymous' => %i(anonymous_enabled anonymous_org_name anonymous_org_role),
    'auth_basic' => %i(basic_enabled),
    'auth_generic_oauth' => %i(
      generic_oauth_name
      generic_oauth_enabled
      generic_oauth_allow_sign_up
      generic_oauth_client_id
      generic_oauth_client_secret
      generic_oauth_scopes
      generic_oauth_email_attribute_name
      generic_oauth_auth_url
      generic_oauth_token_url
      generic_oauth_api_url
      generic_oauth_team_ids
      generic_oauth_allowed_organizations
      generic_oauth_tls_skip_verify_insecure
      generic_oauth_tls_client_cert
      generic_oauth_tls_client_key
      generic_oauth_tls_client_ca
      generic_oauth_send_client_credentials_via_post
      generic_oauth_role_attribute_path
    ),
    'auth_github' => %i(
      github_enabled
      github_allow_sign_up
      github_client_id
      github_client_secret
      github_scopes
      github_auth_url
      github_token_url
      github_api_url
      github_team_ids
      github_allowed_organizations
    ),
    'auth_gitlab' => %i(
      gitlab_enabled
      gitlab_allow_sign_up
      gitlab_client_id
      gitlab_client_secret
      gitlab_scopes
      gitlab_auth_url
      gitlab_token_url
      gitlab_api_url
      gitlab_allowed_groups
    ),
    'auth_google' => %i(
      google_enabled
      google_allow_sign_up
      google_client_id
      google_client_secret
      google_scopes
      google_auth_url
      google_token_url
      google_api_url
      google_allowed_domains
      google_hosted_domain
    ),
    'auth_grafanacom' => %i(
      grafanacom_enabled
      grafanacom_allow_sign_up
      grafanacom_client_id
      grafanacom_client_secret
      grafanacom_scopes
      grafanacom_allowed_organizations
    ),
    'auth_grafananet' => %i(
      grafananet_enabled
      grafananet_allow_sign_up
      grafananet_client_id
      grafananet_client_secret
      grafananet_scopes
      grafananet_allowed_organizations
    ),
    'auth_ldap' => %i(ldap_enabled ldap_config_file ldap_allow_sign_up),
    'auth_proxy' => %i(proxy_enabled proxy_header_name proxy_header_property proxy_auto_sign_up proxy_ldap_sync_ttl proxy_whitelist proxy_headers),

  }.freeze
end

action :install do
  RESOURCE_PROPERTIES.each do |type, properties|
    properties.each do |rp|
      next if nil_or_empty?(new_resource.send(rp))

      property_prefix = "#{type.delete_prefix('auth_')}_"
      run_state_config_set(rp.to_s.delete_prefix(property_prefix), new_resource.send(rp), new_resource.instance_name, 'config', type)
    end
  end
end
