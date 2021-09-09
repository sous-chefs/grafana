# Cookbook:: grafana
# Resource:: config_auth
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

property :login_cookie_name, String

property :disable_login_form, [true, false],
          default: false

property :disable_signout_menu, [true, false],
          default: false

property :signout_redirect_url, String

property :oauth_auto_login, [true, false],
          default: false

property :login_maximum_lifetime_days, Integer,
          required: false

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp))
  end
end
