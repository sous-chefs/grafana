#
# Cookbook:: grafana
# Resource:: config_security
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
# Configures the installed grafana instance

unified_mode true

use 'partial/_config_file'

property :admin_user, String

property :admin_password, String

property :secret_key, String

property :login_remember_days, Integer

property :cookie_username, String

property :cookie_remember_name, String

property :disable_gravatar, [true, false]

property :data_source_proxy_whitelist, String

property :disable_brute_force_login_protection, [true, false]

property :allow_embedding, [true, false]

property :cookie_secure, [true, false]

property :cookie_samesite, String

property :disable_initial_admin_creation, [true, false]

property :strict_transport_security, [true, false]

property :strict_transport_security_max_age_seconds, Integer

property :strict_transport_security_preload, [true, false]

property :strict_transport_security_subdomains, [true, false]

property :x_content_type_options, [true, false]

property :x_xss_protection, [true, false]

property :content_security_policy, [true, false]

property :content_security_policy_template, String
