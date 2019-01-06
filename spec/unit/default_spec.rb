require 'spec_helper'

platforms = {
  'debian' => {
    'versions' => ['8.10'],
  },
  'ubuntu' => {
    'versions' => ['16.04', '18.04'],
  },
  'centos' => {
    'versions' => ['6.9', '7.4.1708'],
  },
}
platforms.each do |platform, value|
  value['versions'].each do |version|
    describe "Default recipe on #{platform} #{version}" do
      let(:runner) { ChefSpec::ServerRunner.new(platform: platform, version: version, step_into: ['grafana_install']) }

      it 'converges successfully' do
        expect { :chef_run }.to_not raise_error
      end
    end
  end
end
