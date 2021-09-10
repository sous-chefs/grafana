#
# Cookbook:: grafana
# Resource:: config_users
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

property :allow_sign_up, [true, false]

property :allow_org_create, [true, false]

property :auto_assign_org, [true, false]

property :auto_assign_org_id, Integer

property :auto_assign_org_role, String

property :verify_email_enabled, [true, false]

property :login_hint, String

property :default_theme, [Symbol, String],
          equal_to: [:dark, :light, 'dark', 'light'],
          coerce: proc { |p| p.to_s }

property :home_page, String

property :external_manage_link_url, String

property :external_manage_link_name, String

property :external_manage_info, String

property :viewers_can_edit, [true, false]

property :editors_can_admin, [true, false]

property :user_invite_max_lifetime_duration, String

property :hidden_users, [String, Array],
          coerce: proc { |p| Array(p).join(',') }
