require 'spec_helper'

platforms = %w(debian ubuntu centos)
platforms.each do |platform|
  describe "grafana_ on #{platform}" do
    step_into :grafana_config, :grafana_install, :grafana_config_ldap_attributes, :grafana_config_ldap_server, :grafana_config_ldap_group_mapping, :grafana_config_writer
    platform platform

    context 'create ldap config' do
      recipe do
        grafana_install 'package'

        grafana_config 'Grafana' do
        end

        grafana_config_ldap_server 'Grafana' do
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

        grafana_config_ldap_attributes 'Grafana' do
          host '127.0.0.1'
        end

        grafana_config_ldap_group_mapping 'admins' do
          host '127.0.0.1'
          group_dn      'cn=admins,dc=grafana,dc=org'
          org_role      'Admin'
          grafana_admin true
          org_id        1
        end

        grafana_config_ldap_group_mapping 'readers' do
          host '127.0.0.1'
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
