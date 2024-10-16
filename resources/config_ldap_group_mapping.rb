#
# Cookbook:: grafana
# Resource:: config_ldap_group_mapping
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
          required: true,
          desired_state: false,
          description: 'The LDAP host to apply the group mapping to'

property :group_dn, String,
          name_property: true

property :org_role, String,
          equal_to: %w(Admin Editor Viewer),
          required: true

property :grafana_admin, [true, false]

property :org_id, Integer

load_current_value do |new_resource|
  current_config = load_file_ldap_config_host_group_mapping(new_resource.config_file, new_resource.host, new_resource.group_dn)

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

def resource_config_properties_skip
  %i(host).freeze
end

action_class do
  def ldap_server_exist?
    !ldap_server_config(new_resource.host).nil?
  end

  def group_mapping_exist?
    return unless ldap_server_exist?

    group_mappings = ldap_server_config(new_resource.host).fetch('group_mappings', nil)

    return unless group_mappings

    group_mappings.any? { |gm| gm['group_dn'].eql?(new_resource.group_dn) && gm['org_role'].eql?(new_resource.org_role) && gm['org_id'].eql?(new_resource.org_id) }
  end

  def remove_group_mapping
    return unless ldap_server_exist?

    group_mappings = ldap_server_config(new_resource.host).fetch('group_mappings', nil)

    return unless group_mappings

    group_mappings.delete_if { |gm| gm['group_dn'].eql?(new_resource.group_dn) && gm['org_role'].eql?(new_resource.org_role) && gm['org_id'].eql?(new_resource.org_id) }
  end
end

action :create do
  raise "No configuration found for LDAP server #{new_resource.host}, unable to apply group mapping" unless ldap_server_config(new_resource.host)

  converge_if_changed do
    mapping = resource_properties.map do |rp|
      next if nil_or_empty?(new_resource.send(rp))
      [rp.to_s, new_resource.send(rp)]
    end.compact.to_h

    remove_group_mapping if group_mapping_exist?
    ldap_server_config(new_resource.host)['group_mappings'] ||= []
    ldap_server_config(new_resource.host)['group_mappings'].push(mapping)
    ldap_server_config(new_resource.host)['group_mappings'].sort_by! { |gm| gm['org_id'] }
  end
end

action :delete do
  converge_by("Remove LDAP server #{new_resource.host} group mapping for #{new_resource.group_dn} from OrgID #{new_resource.org_id}") { remove_group_mapping } if group_mapping_exist?
end
