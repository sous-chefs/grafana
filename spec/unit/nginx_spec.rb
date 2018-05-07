require 'spec_helper'

describe 'grafana::_nginx' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge described_recipe
  end

  it 'enables a nginx site' do
    expect(chef_run).to enable_nginx_site('Grafana')
  end
end
