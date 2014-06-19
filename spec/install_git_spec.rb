require 'spec_helper'

describe 'grafana::_install_git' do

  let(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end
  let(:grafana) { chef_run.node['grafana'] }

  it 'loads git recipe' do
    expect(chef_run).to include_recipe 'git'
  end

  it 'clones grafana from git repository' do
    expect(chef_run).to sync_git('/srv/apps/grafana/master').with(
      repository: grafana['git']['url'],
      reference: grafana['git']['branch'],
      user: chef_run.node['nginx']['user']
    )
  end

  it 'links the git repository to a directory named current' do
    target = "#{grafana['install_dir']}/current"
    expect(chef_run).to create_link(target)
  end
end
