require "spec_helper"

module ChefSpecArkMatchers
  def put_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new :ark, :put, resource_name
  end
end

describe "grafana::install_file" do

  include ChefSpecArkMatchers

  let(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  it 'install grafana from remote url using ark' do
    expect(chef_run).to put_ark("grafana").with(
      url: chef_run.node['grafana']['file']['url'],
      path: chef_run.node['grafana']['install_path'],
      checksum: chef_run.node['grafana']['file']['checksum'],
      owner: chef_run.node['nginx']['user'],
      strip_leading_dir: true
    )
  end

end
