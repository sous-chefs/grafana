describe command('grafana-cli plugins ls') do
  its(:stdout) { should include 'grafana-clock-panel' }
end

describe http('http://localhost:3000/api/frontend/settings') do
  its('status') { should eq 200 }

  let(:json) { JSON.parse(subject.body) }
  it { expect(json).to be_a Hash }

  it { expect(json).to have_key 'panels' }
  it { expect(json['panels']).to have_key 'grafana-clock-panel' }
end
