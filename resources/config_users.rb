#
# Cookbook Name:: grafana
# Resource:: config
#
# Copyright 2014, Jonathan Tron
# Copyright 2017, Andrei Skopenko
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

property  :instance_name,       String, name_property: true
property  :var1,            String, default: 'var1'
property  :var2,       String, default: 'var2'
property  :conf_directory,      String, default: '/etc/grafana'
property  :config_file,         String, default: lazy { ::File.join(conf_directory, 'grafana.ini') }

action :install do

  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source lazy { node.run_state['grafana']['conf_template_source'][new_resource.config_file] ||= 'grafana.ini.erb' }
      cookbook lazy { node.run_state['grafana']['conf_cookbook'][new_resource.config_file] ||= 'grafana' }
      variables['global'] ||= {}
      variables['global']['area1'] ||= {}

      variables['global']['area1']['var1'] ||= '' unless new_resource.var1.nil?
      variables['global']['area1']['var1'] << new_resource.var1 unless new_resource.var1.nil?
      variables['global']['area1']['var2'] ||= '' unless new_resource.var2.nil?
      variables['global']['area1']['var2'].<< new_resource.var2 unless new_resource.var2.nil?

      action :nothing
      delayed_action :create
    end
end
end
