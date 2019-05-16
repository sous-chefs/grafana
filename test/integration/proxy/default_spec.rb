def sys_dir
  os[:family] =~ /redhat/ ? 'sysconfig' : 'default'
end

describe file('/usr/sbin/grafana-server') do
  it { should be_a_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("/etc/#{sys_dir}/grafana-server") do
  it { should be_a_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/grafana/grafana.ini') do
  it { should be_a_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'grafana' }
end

describe file('/etc/grafana/ldap.toml') do
  it { should be_a_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'grafana' }
end

describe service('grafana-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
end

auth_headers = { 'X-WEBAUTH-USER' => 'admin' }
describe http('http://localhost:3000/api/users', headers: auth_headers) do
  its('status') { should eq 200 }

  let(:example_user) { json.find { |user| user['login'] == 'j.smith' } }
  it { expect(example_user).to include('isAdmin' => true) }
end

describe http('http://localhost:3000/api/org/users', headers: auth_headers) do
  its('status') { should eq 200 }

  let(:example_user) { json.find { |user| user['orgId'] == 1 && user['login'] == 'j.smith' } }
  it do
    expect(example_user).to include(
      'orgId' => 1,
      'role' => 'Admin'
    )
  end
end
