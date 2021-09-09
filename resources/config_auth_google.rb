# Cookbook:: grafana
# Resource:: config_auth_google
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

property :enabled, [true, false],
          default: false

property :allow_sign_up, [true, false]

property :client_id, String

property :client_secret, String

property :scopes, String,
          default: 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'

property :auth_url, String,
          default: 'https://accounts.google.com/o/oauth2/auth'

property :token_url, String,
          default: 'https://accounts.google.com/o/oauth2/token'

property :api_url, String,
          default: 'https://www.googleapis.com/oauth2/v1/userinfo'

property :allowed_domains, String

property :hosted_domain, String

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp))
  end
end
