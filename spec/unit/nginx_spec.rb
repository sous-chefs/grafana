require 'spec_helper'

describe 'grafana::_nginx' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', :version => '7.5.1804').converge described_recipe
  end

  it 'enables a nginx site' do
    expect(chef_run).to enable_nginx_site('Grafana')
  end
end
