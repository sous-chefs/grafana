require "spec_helper"

describe "grafana::install_git" do

  let(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  it 'loads git recipe' do
    expect(chef_run).to include_recipe "git"
  end

  it 'clones grafana from git repository' do
    expect(chef_run).to sync_git("/opt/grafana/master").with(
      repository: chef_run.node['grafana']['git']['url'],
      reference: chef_run.node['grafana']['git']['branch'],
      user: chef_run.node['nginx']['user']
    )
  end

end
