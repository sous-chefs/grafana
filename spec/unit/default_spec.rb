require 'spec_helper'

describe 'grafana::default' do
  platforms = {
    'debian' => {
      'versions' => ['7.4']
    },
    'ubuntu' => {
      'versions' => ['12.04', '14.04']
    },
    'centos' => {
      'versions' => ['6.4', '6.6']
    }
  }

  let(:chef_solo_opts) do
    {
      platform: platform,
      version: version,
      file_cache_path: '/var/chef/cache'
    }
  end

  let(:grafana_version) { '2.1.2' }

  platforms.each do |ext_platform, value|
    value['versions'].each do |ext_version|
      context "on #{ext_platform} #{ext_version}" do
        let(:platform) { ext_platform }
        let(:version) { ext_version }

        before do
          stub_command("dpkg -l | grep '^ii' | grep grafana | grep #{grafana_version}")
          stub_command("yum list installed | grep grafana | grep #{grafana_version}")
        end

        context 'with default attributes' do
          before do
            stub_command 'which nginx'
          end

          let(:chef_run) do
            ChefSpec::SoloRunner.new(chef_solo_opts).converge described_recipe
          end

          it 'installs grafana package' do
            if platform == 'centos'
              expect(chef_run).to install_rpm_package("grafana-#{grafana_version}")
            else
              expect(chef_run).to install_dpkg_package("grafana-#{grafana_version}")
            end
          end

          it 'loads grafana::_nginx recipe' do
            expect(chef_run).to include_recipe 'grafana::_nginx'
          end

          it 'loads grafana::_install_file recipe' do
            expect(chef_run).to include_recipe 'grafana::_install_file'
          end

          it 'create log and data directories' do
            expect(chef_run).to create_directory('/var/lib/grafana').with(mode: '0755')
            expect(chef_run).to create_directory('/var/log/grafana').with(mode: '0755')
          end

          it 'generate grafana.ini' do
            expect(chef_run).to create_template('/etc/grafana/grafana.ini').with(
              mode: '0644',
              user: 'root'
            )

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[database\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^host = 127.0.0.1:3306/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# ssl_mode = disable/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^path = grafana.db/)

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[server\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^protocol = http/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^http_port = 3000/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^domain = localhost/)

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[paths\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^data = /var/lib/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^logs = /var/log/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^plugins = /var/lib/grafana/plugins})
          end

          it 'generate grafana-server environment vars' do
            expect(chef_run).to create_template('/etc/default/grafana-server')
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^GRAFANA_USER=grafana})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^GRAFANA_GROUP=grafana})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^GRAFANA_HOME=/usr/share/grafana})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^LOGS_DIR=/var/log/grafana})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^DATA_DIR=/var/lib/grafana})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^PLUGINS_DIR=/var/lib/grafana/plugins})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^MAX_OPEN_FILES=10000})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^CONF_DIR=/etc/grafana})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^CONF_FILE=/etc/grafana/grafana.ini})
            expect(chef_run).to render_file('/etc/default/grafana-server').with_content(%r{^RESTART_ON_UPGRADE=false})
          end

          it 'enable grafana-server service' do
            expect(chef_run).to enable_service('grafana-server')
          end

          it 'does not include recipe _ldap_config' do
            expect(chef_run).to_not include_recipe('grafana::_ldap_config')
          end
        end

        context 'with no webserver' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(chef_solo_opts) do |node|
              node.set['grafana']['webserver'] = ''
            end.converge described_recipe
          end

          it 'installs grafana package' do
            if platform == 'centos'
              expect(chef_run).to install_package 'initscripts'
              expect(chef_run).to install_package 'fontconfig'
              expect(chef_run).to create_remote_file "/var/chef/cache/grafana-#{grafana_version}.rpm"
              expect(chef_run).to install_rpm_package "grafana-#{grafana_version}"
            else
              expect(chef_run).to install_package 'adduser'
              expect(chef_run).to install_package 'libfontconfig'
              expect(chef_run).to create_remote_file "/var/chef/cache/grafana-#{grafana_version}.deb"
              expect(chef_run).to install_dpkg_package "grafana-#{grafana_version}"
            end
          end

          it 'do not load grafana::nginx recipe' do
            expect(chef_run).not_to include_recipe 'grafana::_nginx'
          end

          it 'loads grafana::_install_file recipe' do
            expect(chef_run).to include_recipe 'grafana::_install_file'
          end

          it 'generate grafana.ini' do
            expect(chef_run).to create_template('/etc/grafana/grafana.ini').with(
              mode: '0644',
              user: 'root'
            )

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[database\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^data = /var/lib/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^host = 127.0.0.1:3306/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# ssl_mode = disable/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^path = grafana.db/)

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[server\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^protocol = http/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^http_port = 3000/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^domain = localhost/)

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[paths\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^data = /var/lib/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^logs = /var/log/grafana})
          end
          it 'does not include recipe _ldap_config' do
            expect(chef_run).to_not include_recipe('grafana::_ldap_config')
          end
        end

        context 'with LDAP authentication enabled' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(chef_solo_opts) do |node|
              node.set['grafana']['ini']['auth.ldap']['enabled']['value'] = true
            end.converge described_recipe
          end
          before do
            stub_command 'which nginx'
          end

          it 'installs grafana package' do
            if platform == 'centos'
              expect(chef_run).to install_rpm_package("grafana-#{grafana_version}")
            else
              expect(chef_run).to install_dpkg_package("grafana-#{grafana_version}")
            end
          end

          it 'loads grafana::_nginx recipe' do
            expect(chef_run).to include_recipe 'grafana::_nginx'
          end

          it 'loads grafana::_install_file recipe' do
            expect(chef_run).to include_recipe 'grafana::_install_file'
          end

          it 'loads grafana::_ldap_config recipe' do
            expect(chef_run).to include_recipe 'grafana::_ldap_config'
          end

          it 'create log and data directories' do
            expect(chef_run).to create_directory('/var/lib/grafana').with(mode: '0755')
            expect(chef_run).to create_directory('/var/log/grafana').with(mode: '0755')
          end

          it 'generate grafana.ini' do
            expect(chef_run).to create_template('/etc/grafana/grafana.ini').with(
              mode: '0644',
              user: 'root'
            )
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[database\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^data = /var/lib/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^host = 127.0.0.1:3306/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# ssl_mode = disable/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^path = grafana.db/)

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[server\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^protocol = http/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^http_port = 3000/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^domain = localhost/)

            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^\[paths\]/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^data = /var/lib/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^logs = /var/log/grafana})
          end

          it 'generate ldap.toml' do
            expect(chef_run).to create_template('/etc/grafana/ldap.toml').with(
              mode: '0644',
              user: 'root'
            )

            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^verbose_logging = false/)

            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^\[\[servers\]\]/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^host = "127.0.0.1"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^port = 389/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^use_ssl = false/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^ssl_skip_verify = false/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^bind_dn = "cn=admin,dc=grafana,dc=org"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^bind_password = grafana/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^search_filter = "\(cn=%s\)"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^search_base_dns = \["dc=grafana,dc=org"\]/)

            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^\[servers.attributes\]/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^name = "givenName"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^surname = "sn"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^username = "cn"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^member_of = "memberOf"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^email = "email"/)

            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^\[\[servers.group_mappings\]\]/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^group_dn = "cn=admins,dc=grafana,dc=org"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^org_role = "Admin"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^# org_id = 1/)

            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^\[\[servers.group_mappings\]\]/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^group_dn = "cn=users,dc=grafana,dc=org"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^org_role = "Editor"/)

            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^\[\[servers.group_mappings\]\]/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^group_dn = "*"/)
            expect(chef_run).to render_file('/etc/grafana/ldap.toml').with_content(/^org_role = "Viewer"/)
          end

          it 'generate grafana-server environment vars' do
            expect(chef_run).to create_template('/etc/default/grafana-server')
          end

          it 'enable grafana-server service' do
            expect(chef_run).to enable_service('grafana-server')
          end
        end
      end
    end
  end
end
