require_relative '_utils'
require_relative 'toml'

module Grafana
  module Cookbook
    module LdapConfigFile
      include Grafana::Cookbook::TomlHelper
      include Grafana::Cookbook::Utils

      private

      def load_file_ldap_config_host(config_file, host)
        return unless ::File.exist?(config_file)

        load_tomlfile(config_file).fetch('servers', {}).select { |s| s['host'].eql?(host) }.first
      end

      def load_file_ldap_config_host_attributes(config_file, host)
        host_config = load_file_ldap_config_host(config_file, host)

        return if nil_or_empty?(host_config)

        host_config.fetch('attributes')
      end

      def load_file_ldap_config_host_group_mapping(config_file, host, group_dn)
        host_config = load_file_ldap_config_host(config_file, host)

        return if nil_or_empty?(host_config)

        host_config.fetch('group_mappings').select { |gm| gm['group_dn'].eql?(group_dn) }.first
      end
    end
  end
end
