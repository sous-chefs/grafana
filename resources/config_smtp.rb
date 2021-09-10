#
# Cookbook:: grafana
# Resource:: config_smtp
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

property :host, String

property :user, String

property :password, String

property :cert_file, String

property :key_file, String

property :skip_verify, [true, false],
          default: false

property :from_address, String

property :from_name, String

property :ehlo_identity, String

property :startTLS_policy, String,
          equal_to: %w(OpportunisticStartTLS MandatoryStartTLS NoStartTLS)
