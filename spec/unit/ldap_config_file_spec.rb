# frozen_string_literal: true

require 'spec_helper'
require 'tempfile'
require_relative '../../libraries/ldap_config_file'

RSpec.describe Grafana::Cookbook::LdapConfigFile do
  subject(:helper) do
    Class.new do
      include Grafana::Cookbook::LdapConfigFile
    end.new
  end

  let(:config_file) do
    file = Tempfile.new('ldap.toml')
    file.write(<<~TOML)
      [[servers]]
      host = "127.0.0.1"

      [[servers.group_mappings]]
      group_dn = "cn=admins,dc=grafana,dc=org"
      org_role = "Admin"
      org_id = 1

      [[servers.group_mappings]]
      group_dn = "cn=readers,dc=grafana,dc=org"
      org_role = "Viewer"
      org_id = 1
    TOML
    file.close
    file
  end

  after do
    config_file.unlink
  end

  describe '#load_file_ldap_config_host_group_mapping' do
    it 'loads the current mapping by group DN' do
      mapping = helper.send(
        :load_file_ldap_config_host_group_mapping,
        config_file.path,
        '127.0.0.1',
        'cn=readers,dc=grafana,dc=org'
      )

      expect(mapping).to include(
        'group_dn' => 'cn=readers,dc=grafana,dc=org',
        'org_role' => 'Viewer',
        'org_id' => 1
      )
    end
  end
end
