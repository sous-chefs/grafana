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

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log']['mode'] ||= '' unless new_resource.mode.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log']['mode'] << new_resource.mode.to_s unless new_resource.mode.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log']['level'] ||= '' unless new_resource.level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log']['level'] << new_resource.level.to_s unless new_resource.level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log']['filters'] ||= '' unless new_resource.filters.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log']['filters'] << new_resource.filters.to_s unless new_resource.filters.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_console'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_console']['level'] ||= '' unless new_resource.console_level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_console']['level'] << new_resource.console_level.to_s unless new_resource.console_level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_console']['format'] ||= '' unless new_resource.console_format.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_console']['format'] << new_resource.console_format.to_s unless new_resource.console_format.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['level'] ||= '' unless new_resource.file_level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['level'] << new_resource.file_level.to_s unless new_resource.file_level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['format'] ||= '' unless new_resource.file_format.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['format'] << new_resource.file_format.to_s unless new_resource.file_format.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['log_rotate'] ||= '' unless new_resource.file_log_rotate.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['log_rotate'] << new_resource.file_log_rotate.to_s unless new_resource.file_log_rotate.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['max_lines'] ||= '' unless new_resource.file_max_lines.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['max_lines'] << new_resource.file_max_lines.to_s unless new_resource.file_max_lines.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['max_size_shift'] ||= '' unless new_resource.file_max_size_shift.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['max_size_shift'] << new_resource.file_max_size_shift.to_s unless new_resource.file_max_size_shift.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['daily_rotate'] ||= '' unless new_resource.file_daily_rotate.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['daily_rotate'] << new_resource.file_daily_rotate.to_s unless new_resource.file_daily_rotate.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['max_days'] ||= '' unless new_resource.file_max_days.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_file']['max_days'] << new_resource.file_max_days.to_s unless new_resource.file_max_days.nil?

  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['level'] ||= '' unless new_resource.syslog_level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['level'] << new_resource.syslog_level.to_s unless new_resource.syslog_level.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['format'] ||= '' unless new_resource.syslog_format.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['format'] << new_resource.syslog_format.to_s unless new_resource.syslog_format.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['network'] ||= '' unless new_resource.syslog_network.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['network'] << new_resource.syslog_network.to_s unless new_resource.syslog_network.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['address'] ||= '' unless new_resource.syslog_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['address'] << new_resource.syslog_address.to_s unless new_resource.syslog_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['facility'] ||= '' unless new_resource.syslog_facility.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['facility'] << new_resource.syslog_facility.to_s unless new_resource.syslog_facility.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['tag'] ||= '' unless new_resource.syslog_tag.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['log_syslog']['tag'] << new_resource.syslog_tag.to_s unless new_resource.syslog_tag.nil?
end
