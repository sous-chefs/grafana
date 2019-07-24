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

property  :instance_name,     String,         name_property: true
property  :conf_directory,    String,         default: '/etc/grafana'
property  :config_file,       String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :protocol,          String,         default: 'http', equal_to: %w(http https socket)
property  :http_addr,         String,         default: ''
property  :http_port,         Integer,        default: 3000
property  :domain,            String,         default: node['hostname']
property  :root_url,          String,         default: '%(protocol)s://%(domain)s:%(http_port)s/'
property  :enforce_domain,    [true, false],  default: false
property  :router_logging,    [true, false],  default: false
property  :static_root_path,  String,         default: 'public'
property  :enable_gzip,       [true, false],  default: false
property  :cert_file,         String,         default: ''
property  :cert_key,          String,         default: ''
property  :router_logging,    String,         default: '/tmp/grafana.sock'
property  :cookbook,          String,         default: 'grafana'
property  :source,            String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['server'] ||= {}
      variables['grafana']['server']['protocol'] ||= '' unless new_resource.protocol.nil?
      variables['grafana']['server']['protocol'] << new_resource.protocol.to_s unless new_resource.protocol.nil?
      variables['grafana']['server']['http_addr'] ||= '' unless new_resource.http_addr.nil?
      variables['grafana']['server']['http_addr'] << new_resource.http_addr.to_s unless new_resource.http_addr.nil?
      variables['grafana']['server']['http_port'] ||= '' unless new_resource.http_port.nil?
      variables['grafana']['server']['http_port'] << new_resource.http_port.to_s unless new_resource.http_port.nil?
      variables['grafana']['server']['domain'] ||= '' unless new_resource.domain.nil?
      variables['grafana']['server']['domain'] << new_resource.domain.to_s unless new_resource.domain.nil?
      variables['grafana']['server']['root_url'] ||= '' unless new_resource.root_url.nil?
      variables['grafana']['server']['root_url'] << new_resource.root_url.to_s unless new_resource.root_url.nil?
      variables['grafana']['server']['enforce_domain'] ||= '' unless new_resource.enforce_domain.nil?
      variables['grafana']['server']['enforce_domain'] << new_resource.enforce_domain.to_s unless new_resource.enforce_domain.nil?
      variables['grafana']['server']['router_logging'] ||= '' unless new_resource.router_logging.nil?
      variables['grafana']['server']['router_logging'] << new_resource.router_logging.to_s unless new_resource.router_logging.nil?
      variables['grafana']['server']['static_root_path'] ||= '' unless new_resource.static_root_path.nil?
      variables['grafana']['server']['static_root_path'] << new_resource.static_root_path.to_s unless new_resource.static_root_path.nil?
      variables['grafana']['server']['enable_gzip'] ||= '' unless new_resource.enable_gzip.nil?
      variables['grafana']['server']['enable_gzip'] << new_resource.enable_gzip.to_s unless new_resource.enable_gzip.nil?
      variables['grafana']['server']['cert_file'] ||= '' unless new_resource.cert_file.nil?
      variables['grafana']['server']['cert_file'] << new_resource.cert_file.to_s unless new_resource.cert_file.nil?
      variables['grafana']['server']['cert_key'] ||= '' unless new_resource.cert_key.nil?
      variables['grafana']['server']['cert_key'] << new_resource.cert_key.to_s unless new_resource.cert_key.nil?

      action :nothing
      delayed_action :create
    end
  end
end
