#
# Cookbook:: grafana
# Resource:: config_server
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

property  :instance_name,        String,         name_property: true
property  :protocol,             Symbol,         default: :http, equal_to: %i( http https socket )
property  :http_addr,            String,         default: ''
property  :http_port,            Integer,        default: 3000
property  :domain,               String,         default: lazy { node['hostname'] }
property  :root_url,             String,         default: '%(protocol)s://%(domain)s:%(http_port)s/'
property  :serve_from_sub_path,  [true, false],  default: false
property  :enforce_domain,       [true, false],  default: false
property  :router_logging,       [true, false],  default: false
property  :static_root_path,     String,         default: 'public'
property  :enable_gzip,          [true, false],  default: false
property  :cert_file,            String,         default: ''
property  :cert_key,             String,         default: ''

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['protocol'] ||= '' unless new_resource.protocol.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['protocol'] << new_resource.protocol.to_s unless new_resource.protocol.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['http_addr'] ||= '' unless new_resource.http_addr.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['http_addr'] << new_resource.http_addr.to_s unless new_resource.http_addr.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['http_port'] ||= '' unless new_resource.http_port.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['http_port'] << new_resource.http_port.to_s unless new_resource.http_port.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['domain'] ||= '' unless new_resource.domain.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['domain'] << new_resource.domain.to_s unless new_resource.domain.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['root_url'] ||= '' unless new_resource.root_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['root_url'] << new_resource.root_url.to_s unless new_resource.root_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['serve_from_sub_path'] ||= '' unless new_resource.serve_from_sub_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['serve_from_sub_path'] << new_resource.serve_from_sub_path.to_s unless new_resource.serve_from_sub_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['enforce_domain'] ||= '' unless new_resource.enforce_domain.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['enforce_domain'] << new_resource.enforce_domain.to_s unless new_resource.enforce_domain.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['router_logging'] ||= '' unless new_resource.router_logging.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['router_logging'] << new_resource.router_logging.to_s unless new_resource.router_logging.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['static_root_path'] ||= '' unless new_resource.static_root_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['static_root_path'] << new_resource.static_root_path.to_s unless new_resource.static_root_path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['enable_gzip'] ||= '' unless new_resource.enable_gzip.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['enable_gzip'] << new_resource.enable_gzip.to_s unless new_resource.enable_gzip.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['cert_file'] ||= '' unless new_resource.cert_file.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['cert_file'] << new_resource.cert_file.to_s unless new_resource.cert_file.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['cert_key'] ||= '' unless new_resource.cert_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['server']['cert_key'] << new_resource.cert_key.to_s unless new_resource.cert_key.nil?
end
