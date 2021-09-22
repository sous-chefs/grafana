#
# Cookbook:: grafana
# Resource:: config_date_formats
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

property :full_date, String

property :interval_second, String

property :interval_minute, String

property :interval_hour, String

property :interval_day, String

property :interval_month, String

property :interval_year, String

property :use_browser_locale, [true, false]

property :default_timezone, String

def resource_config_path_override
  %w(date_formats)
end
