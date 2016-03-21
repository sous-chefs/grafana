require 'spec_helper'

describe 'grafana::_nginx' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge described_recipe
  end

  it 'creates a template with attributes' do
    stub_command('which nginx').and_return('/usr/bin/nginx')
    expect(chef_run).to create_template('/etc/nginx/sites-available/grafana')
  end

  it 'creates a template with auth basic attributes' do
    stub_command('which nginx').and_return('/usr/bin/nginx')
    chef_run.node.set['grafana']['nginx']['auth_basic'] = true
    chef_run.converge(described_recipe)
    expect(chef_run).to create_template('/etc/nginx/sites-available/grafana')
    expect(chef_run).to render_file('/etc/nginx/sites-available/grafana').with_content(/auth_basic_user_file.+/)
  end
end
