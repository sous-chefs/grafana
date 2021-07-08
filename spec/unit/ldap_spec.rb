require 'spec_helper'

platforms = %w(debian ubuntu centos)
platforms.each do |platform|
  describe "grafana_ on #{platform}" do
    step_into :grafana_config, :grafana_install, :grafana_config_ldap, :grafana_config_ldap_servers, :grafana_config_ldap_group_mappings, :grafana_config_writer
    platform platform

    context 'create ldap config' do
      recipe do
        grafana_install 'package'

        grafana_config 'Grafana' do
        end

        grafana_config_ldap 'Grafana'

        grafana_config_ldap_servers 'Grafana' do
          host            '127.0.0.1'
          port            389
          use_ssl         false
          start_tls       false
          ssl_skip_verify false
          bind_dn         'cn=admin,dc=grafana,dc=org'
          bind_password   'SuperSecretPassword'
          search_filter   '(cn=%s)'
          search_base_dns %w( dc=grafana,dc=org )
        end

        grafana_config_ldap_group_mappings 'Grafana' do
          group_dn      'cn=admins,dc=grafana,dc=org'
          org_role      'Admin'
          grafana_admin true
          org_id        1
        end

        grafana_config_ldap_group_mappings 'Grafana' do
          group_dn  'cn=readers,dc=grafana,dc=org'
          org_role  'Viewer'
        end
      end

      it('should render config file') do
        is_expected.to render_file('/etc/grafana/ldap.toml').with_content(/org_role = \"Viewer\"/)
        is_expected.to render_file('/etc/grafana/ldap.toml').with_content(/org_role = \"Admin\"/)
        is_expected.to render_file('/etc/grafana/ldap.toml').with_content(/SuperSecretPassword/)
        is_expected.to render_file('/etc/grafana/ldap.toml').with_content(/givenName/)
      end
    end
  end
end
