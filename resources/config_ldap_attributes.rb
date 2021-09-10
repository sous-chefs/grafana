#
# Cookbook:: grafana
# Resource:: config_ldap_attributes
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
use 'partial/_config_file_ldap'

property :host, String,
          name_property: true,
          desired_state: false,
          description: 'The LDAP host to apply the attribute mapping to'

property :attribute_name, String,
          default: 'givenName'

property :attribute_surname, String,
          default: 'sn'

property :attribute_username, String,
          default: 'cn'

property :attribute_member_of, String,
          default: 'memberOf'

property :attribute_email, String,
          default: 'email'

load_current_value do |new_resource|
  current_config = load_file_ldap_config_host_attributes(new_resource.config_file, new_resource.host)

  current_value_does_not_exist! unless current_config

  if ::File.exist?(new_resource.config_file)
    owner ::Etc.getpwuid(::File.stat(new_resource.config_file).uid).name
    group ::Etc.getgrgid(::File.stat(new_resource.config_file).gid).name
    filemode ::File.stat(new_resource.config_file).mode.to_s(8)[-4..-1]
  end

  current_config[:extra_options] = current_config.reject! { |k, _| resource_properties.include?(k) }
  properties = resource_properties
  properties.delete(:host)
  properties.each { |p| send(p, current_config.fetch(p.to_s, nil)) }
end

action_class do
  RESOURCE_CONFIG_PROPERTIES_SKIP = %i(host).freeze

  def resource_config_properties_skip
    RESOURCE_CONFIG_PROPERTIES_SKIP
  end
end

action :create do
  converge_if_changed {}

  template_servers = config_file_template_variables.fetch('servers', nil)
  raise "No servers, got #{template_servers.class} #{template_servers}" unless template_servers

  template_server_index = template_servers.find_index { |s| s['host'].eql?(new_resource.host) }
  raise "No index, got #{template_server_index.class} #{template_server_index}" unless template_server_index

  attributes = resource_properties.map do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    [rp.to_s.delete_prefix('attribute_'), new_resource.send(rp)]
  end.compact.to_h

  template_servers[template_server_index]['attributes'] = attributes
end