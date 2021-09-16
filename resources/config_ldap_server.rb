#
# Cookbook:: grafana
# Resource:: config_ldap_server
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
          required: true

property :port, Integer,
          default: 389

property :use_ssl, [true, false]

property :start_tls, [true, false]

property :ssl_skip_verify, [true, false]

property :root_ca_cert, String

property :client_cert, String

property :client_key, String

property :bind_dn, String

property :bind_password, String,
          sensitive: true

property :search_filter, String

property :search_base_dns, Array

property :group_search_base_dns, Array

property :group_search_filter, String

property :group_search_filter_user_attribute, String

load_current_value do |new_resource|
  current_config = load_file_ldap_config_host(new_resource.config_file, new_resource.host)

  current_value_does_not_exist! unless current_config

  if ::File.exist?(new_resource.config_file)
    owner ::Etc.getpwuid(::File.stat(new_resource.config_file).uid).name
    group ::Etc.getgrgid(::File.stat(new_resource.config_file).gid).name
    filemode ::File.stat(new_resource.config_file).mode.to_s(8)[-4..-1]
  end

  current_config[:extra_options] = current_config.reject! { |k, _| resource_properties.include?(k) }
  resource_properties.each { |p| send(p, current_config.fetch(p.to_s, nil)) }
end

action_class do
  def resource_config_path_override
    [nil] # Add to the root path
  end
end

action :create do
  converge_if_changed do
    ldap_server = resource_properties.map do |rp|
      next if nil_or_empty?(new_resource.send(rp))

      [rp.to_s, new_resource.send(rp)]
    end.compact.to_h

    if ldap_server_config(new_resource.host)
      ldap_server_config(new_resource.host).merge!(ldap_server)
    else
      accumulator_config(:push, 'servers', ldap_server)
    end
  end
end

action :delete do
  converge_by("Remove LDAP server configuration for #{new_resource.host}") do
    config_file_template_variables.fetch('servers').delete_if { |s| s['host'].eql?(new_resource.host) }
  end if ldap_server_config(new_resource.host)
end
