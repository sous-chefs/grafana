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

  platforms.each do |ext_platform, value|
    value['versions'].each do |ext_version|
      context "on #{ext_platform} #{ext_version}" do
        let(:platform) { ext_platform }
        let(:version) { ext_version }

        before do
          stub_command("dpkg -l | grep '^ii' | grep grafana | grep #{chef_run.node['grafana']['version']}")
          stub_command("yum list installed | grep grafana | grep #{chef_run.node['grafana']['version']}")
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
              expect(chef_run).to install_rpm_package("grafana-#{chef_run.node['grafana']['version']}")
            else
              expect(chef_run).to install_dpkg_package("grafana-#{chef_run.node['grafana']['version']}")
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
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(%r{^data = /var/lib/grafana})
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^host = 127.0.0.1:3306/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# For "postgres" only, either "disable", "require" or "verify-full"/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^;ssl_mode = disable/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# For sqlite3 only, path relative to data_path setting/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^path = grafana.db/)
          end

          it 'generate grafana-server environment vars' do
            expect(chef_run).to create_template('/etc/default/grafana-server')
          end

          it 'enable grafana-server service' do
            expect(chef_run).to enable_service('grafana-server')
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
              expect(chef_run).to install_yum_package 'initscripts'
              expect(chef_run).to install_yum_package 'fontconfig'
              expect(chef_run).to create_remote_file "/var/chef/cache/grafana-#{chef_run.node['grafana']['version']}.rpm"
              expect(chef_run).to install_rpm_package "grafana-#{chef_run.node['grafana']['version']}"
            else
              expect(chef_run).to install_apt_package 'adduser'
              expect(chef_run).to install_apt_package 'libfontconfig'
              expect(chef_run).to create_remote_file "/var/chef/cache/grafana-#{chef_run.node['grafana']['version']}.deb"
              expect(chef_run).to install_dpkg_package "grafana-#{chef_run.node['grafana']['version']}"
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
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# For "postgres" only, either "disable", "require" or "verify-full"/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^;ssl_mode = disable/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^# For sqlite3 only, path relative to data_path setting/)
            expect(chef_run).to render_file('/etc/grafana/grafana.ini').with_content(/^path = grafana.db/)
          end
        end
      end
    end
  end
end
