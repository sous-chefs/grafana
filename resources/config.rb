#
# Cookbook:: grafana
# Resource:: config
#
# Copyright:: 2014, Jonathan Tron
# Copyright:: 2017, Andrei Skopenko
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

property :app_mode, String,
          default: 'production',
          equal_to: %w(production development)

property :instance_name, String,
          name_property: true

def resource_config_path_override
  %w(global)
end
