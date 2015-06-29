require 'spec_helper'

describe 'grafana::_install_source' do
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

  platforms.each do |platform, value|
    value['versions'].each do |version|
      before do
        stub_command('which nginx').and_return('/usr/bin/nginx')
      end
      context "on #{platform} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
            node.set['grafana']['install_type'] = 'source'
          end.converge 'grafana::default'
        end

        it 'loads grafana::_install_source recipe' do
          expect(chef_run).to include_recipe 'grafana::_install_source'
        end
      end
    end
  end
end
