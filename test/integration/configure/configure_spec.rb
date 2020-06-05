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
curl_auth_headers = '"X-WEBAUTH-USER: admin"'

describe json(command: "curl http://localhost:3000/api/org --header #{curl_auth_headers}") do
  its('name') { should eq 'Sous-Chefs' }
  its('id') { should eq 2 }
end

describe http('http://localhost:3000/api/users', headers: auth_headers) do
  its('status') { should eq 200 }

  let(:json) { JSON.parse(subject.body) }
  let(:example_user) { json.find { |user| user['login'] == 'foo.bar' } }
  it { expect(example_user).to include('isAdmin' => false) }
end

describe http('http://localhost:3000/api/users', headers: auth_headers) do
  its('status') { should eq 200 }

  let(:json) { JSON.parse(subject.body) }
  let(:example_user) { json.find { |user| user['login'] == 'j.smith' } }
  it { expect(example_user).to include('isAdmin' => true) }
end

describe http('http://localhost:3000/api/org/users', headers: auth_headers) do
  its('status') { should eq 200 }

  let(:json) { JSON.parse(subject.body) }
  let(:example_user) { json.find { |user| user['orgId'] == 2 && user['login'] == 'j.smith' } }
  it do
    expect(example_user).to include(
      'orgId' => 2,
      'role' => 'Admin'
    )
  end
end

describe json(command: "curl http://localhost:3000/api/datasources --header #{curl_auth_headers}") do
  its([0, 'name']) { should eq 'graphite-test' }
  its([0, 'type']) { should eq 'graphite' }
  its([0, 'id']) { should eq 1 }
  its([0, 'orgId']) { should eq 2 }
  its([0, 'access']) { should eq 'direct' }
  # influc
  its([1, 'name']) { should eq 'influxdb-test' }
  its([1, 'type']) { should eq 'influxdb' }
  its([1, 'id']) { should eq 2 }
  its([1, 'orgId']) { should eq 2 }
  its([1, 'isDefault']) { should eq true }
  its([1, 'access']) { should eq 'proxy' }
  its([1, 'url']) { should eq 'http://10.0.0.10:8086' }
  its([1, 'password']) { should eq 'dashpass' }
  its([1, 'user']) { should eq 'dashboard' }
  its([1, 'database']) { should eq 'metrics' }
end

describe json(command: "curl http://localhost:3000/api/dashboards/db/sample-dashboard --header #{curl_auth_headers}") do
  its(%w(meta slug)) { should eq 'sample-dashboard' }
end

# TODO: Find a way to validate the dashboard is in the right folder
describe json(command: "curl http://localhost:3000/api/dashboards/db/sample-dashboard-folder --header #{curl_auth_headers}") do
  its(%w(meta slug)) { should eq 'sample-dashboard-folder' }
end

describe http('http://localhost:3000/api/folders', headers: auth_headers) do
  its('status') { should eq 200 }

  let(:json) { JSON.parse(subject.body) }
  let(:example_folder) { json.find { |folder| folder['title'] == 'StayOrganized2' } }
  it do
    expect(example_folder).to include(
      'title' => 'StayOrganized2'
    )
  end
end

describe json(command: "curl http://localhost:3000/api/admin/setings --header #{curl_auth_headers}") do
  its(%w(dashboards min_refresh_interval)) { should eq '4s' }
  its(%w(dashboards versions_to_keep)) { should eq '2' }
end

# TODO: Find a way to validate the perms are correct
# describe http("http://localhost:3000/api/folders#{example_folder[:uid]}/permissions", headers: auth_headers) do
#   its('status') { should eq 200 }

#   let(:json) { JSON.parse(subject.body) }
#   let(:example_folder_perm) { json.find { |perm| perm['role'] == 'Viewer' } }
#   it do
#     expect(example_folder_perm).to include(
#       'role' => 'Viewer',
#       'permission' => 1
#     )
#   end
# end
