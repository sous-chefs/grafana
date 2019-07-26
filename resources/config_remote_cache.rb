#
# Cookbook Name:: grafana
# Resource:: config_remote_cache
#
# Copyright 2018, Sous Chefs
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
property  :conf_directory,      String,         default: '/etc/grafana'
property  :config_file,         String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :remote_cache_type,   String,         default: 'database', equal_to: %w(redis memcached database)
property  :remote_cache_config, String,         default: ''
property  :cookbook,            String,         default: 'grafana'
property  :source,              String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['remote_cache'] ||= {}
      variables['grafana']['remote_cache']['type'] ||= '' unless new_resource.remote_cache_type.nil?
      variables['grafana']['remote_cache']['type'] << new_resource.remote_cache_type.to_s unless new_resource.remote_cache_type.nil?
      variables['grafana']['remote_cache']['connstr'] ||= '' unless new_resource.remote_cache_config.nil?
      variables['grafana']['remote_cache']['connstr'] << new_resource.remote_cache_config.to_s unless new_resource.remote_cache_config.nil?

      action :nothing
      delayed_action :create
    end
  end
end
