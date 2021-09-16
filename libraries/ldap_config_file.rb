# Cookbook:: grafana
# Library:: ldap_config_file
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

require_relative '_utils'
require_relative 'toml'

module Grafana
  module Cookbook
    module LdapConfigFile
      include Grafana::Cookbook::TomlHelper
      include Grafana::Cookbook::Utils

      private

      def load_file_ldap_config(config_file)
        return unless ::File.exist?(config_file)

        load_tomlfile(config_file)
      end

      def load_file_ldap_config_host(config_file, host)
        return unless ::File.exist?(config_file)

        host = load_file_ldap_config(config_file).fetch('servers', {}).select { |s| s['host'].eql?(host) }.first
        Chef::Log.debug("load_file_ldap_config_host: #{config_file} host #{host} - [#{host.class}] #{host}")

        host
      end

      def load_file_ldap_config_host_attributes(config_file, host)
        host_config = load_file_ldap_config_host(config_file, host)

        return if nil_or_empty?(host_config)

        attributes = host_config.fetch('attributes', nil)
        Chef::Log.debug("load_file_ldap_config_host_attributes: #{config_file} host #{host} - [#{attributes.class}] #{attributes}")

        attributes
      end

      def load_file_ldap_config_host_group_mapping(config_file, host, group_dn)
        host_config = load_file_ldap_config_host(config_file, host)

        return if nil_or_empty?(host_config)

        group_mapping = host_config.fetch('group_mappings', []).select { |gm| gm['group_dn'].eql?(group_dn) }.first
        Chef::Log.debug("load_file_ldap_config_host_group_mapping: #{config_file} host #{host} group #{group_dn} - [#{group_mapping.class}] #{group_mapping}")

        group_mapping
      end
    end
  end
end
