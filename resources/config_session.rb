#
# Cookbook:: grafana
# Resource:: config_session
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
# using session_provider due to: ArgumentError: Property `provider` of resource `` overwrites an existing method.
property  :session_provider,  String,         default: 'file', equal_to: %w(memory file redis mysql postgres memcache)
property  :provider_config,   String,         default: 'sessions'
property  :cookie_name,       String,         default: 'grafana_sess'
property  :cookie_secure,     [true, false],  default: false
property  :session_life_time, Integer,        default: 86400
property  :gc_interval_time,  Integer,        default: 86400
property  :conn_max_lifetime, Integer,        default: 14400
property  :cookbook,          String,         default: 'grafana'
property  :source,            String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['session'] ||= {}
      variables['grafana']['session']['provider'] ||= '' unless new_resource.session_provider.nil?
      variables['grafana']['session']['provider'] << new_resource.session_provider.to_s unless new_resource.session_provider.nil?
      variables['grafana']['session']['provider_config'] ||= '' unless new_resource.provider_config.nil?
      variables['grafana']['session']['provider_config'] << new_resource.provider_config.to_s unless new_resource.provider_config.nil?
      variables['grafana']['session']['cookie_name'] ||= '' unless new_resource.cookie_name.nil?
      variables['grafana']['session']['cookie_name'] << new_resource.cookie_name.to_s unless new_resource.cookie_name.nil?
      variables['grafana']['session']['cookie_secure'] ||= '' unless new_resource.cookie_secure.nil?
      variables['grafana']['session']['cookie_secure'] << new_resource.cookie_secure.to_s unless new_resource.cookie_secure.nil?
      variables['grafana']['session']['session_life_time'] ||= '' unless new_resource.session_life_time.nil?
      variables['grafana']['session']['session_life_time'] << new_resource.session_life_time.to_s unless new_resource.session_life_time.nil?
      variables['grafana']['session']['gc_interval_time'] ||= '' unless new_resource.gc_interval_time.nil?
      variables['grafana']['session']['gc_interval_time'] << new_resource.gc_interval_time.to_s unless new_resource.gc_interval_time.nil?
      variables['grafana']['session']['conn_max_lifetime'] ||= '' unless new_resource.conn_max_lifetime.nil?
      variables['grafana']['session']['conn_max_lifetime'] << new_resource.conn_max_lifetime.to_s unless new_resource.conn_max_lifetime.nil?

      action :nothing
      delayed_action :create
    end
  end
end
