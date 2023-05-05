# Cookbook:: grafana
# Resource:: config_auth_generic_oauth
#
# Copyright:: 2021, Sous Chefs
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

unified_mode true

use 'partial/_config_file'

property :name, String,
          default: 'Generic OAuth'

property :enabled, [true, false],
          default: false

property :allow_sign_up, [true, false]

property :auto_login, [true, false]

property :client_id, String

property :client_secret, String

property :scopes, String

property :email_attribute_path, String

property :login_attribute_path, String

property :name_attribute_path, String

property :auth_url, String

property :token_url, String

property :api_url, String

property :team_ids, String

property :allowed_organizations, String

property :role_attribute_path, String

property :tls_skip_verify_insecure, [true, false]

property :tls_client_cert, String

property :tls_client_key, String

property :tls_client_ca, String

property :send_client_credentials_via_post, [true, false]

def resource_config_path_override
  %w(auth.generic_oauth)
end
