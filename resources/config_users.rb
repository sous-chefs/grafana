#
# Cookbook:: grafana
# Resource:: config_users
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

property  :instance_name,             String,         name_property: true
property  :allow_sign_up,             [true, false],  default: false
property  :allow_org_create,          [true, false],  default: false
property  :auto_assign_org,           [true, false],  default: true
property  :auto_assign_org_id,        Integer,        default: 1
property  :auto_assign_org_role,      String,         default: 'Viewer'
property  :verify_email_enabled,      [true, false],  default: false
property  :login_hint,                String,         default: 'email or username'
property  :default_theme,             Symbol,         default: :dark, equal_to: %i( dark light )
property  :external_manage_link_url,  String,         default: ''
property  :external_manage_link_name, String,         default: ''
property  :external_manage_info,      String,         default: ''
property  :viewers_can_edit,          [true, false],  default: false

action_class do
  include GrafanaCookbook::ConfigHelper
end

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    run_state_config_set(rp.to_s, new_resource.send(rp))
  end
end
