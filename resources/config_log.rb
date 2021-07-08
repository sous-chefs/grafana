#
# Cookbook:: grafana
# Resource:: config_log
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

property  :instance_name,       String,         name_property: true
property  :mode,                String,         default: 'console file'
property  :level,               String,         default: 'info'
property  :filters,             String,         default: ''
property  :console_level,       String,         default: ''
property  :console_format,      String,         default: 'console'
property  :file_level,          String,         default: ''
property  :file_format,         String,         default: 'text'
property  :file_log_rotate,     [true, false],  default: true
property  :file_max_lines,      Integer,        default: 1000000
property  :file_max_size_shift, Integer,        default: 28
property  :file_daily_rotate,   [true, false],  default: true
property  :file_max_days,       Integer,        default: 7
property  :syslog_level,        String,         default: ''
property  :syslog_format,       String,         default: 'text'
property  :syslog_network,      String,         default: ''
property  :syslog_address,      String,         default: ''
property  :syslog_facility,     String,         default: ''
property  :syslog_tag,          String,         default: ''

action_class do
  include GrafanaCookbook::ConfigHelper

  RESOURCE_PROPERTIES = {
    'log' => %i(mode level filters),
    'log_console' => %i(console_level console_format),
    'log_file' => %i(file_level file_format file_log_rotate file_max_lines file_max_size_shift file_daily_rotate file_max_days),
    'log_syslog' => %i(syslog_level syslog_format syslog_network syslog_address syslog_facility syslog_tag),
  }.freeze
end

action :install do
  RESOURCE_PROPERTIES.each do |type, properties|
    properties.each do |rp|
      next if nil_or_empty?(new_resource.send(rp))

      property_prefix = "#{type.delete_prefix('log_')}_"
      run_state_config_set(rp.to_s.delete_prefix(property_prefix), new_resource.send(rp), new_resource.instance_name, 'config', type)
    end
  end
end
