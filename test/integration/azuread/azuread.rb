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

describe service('grafana-server') do
  it { should be_enabled }
  it { should be_running }
end

describe json(content: http('http://localhost:3000/api/admin/settings',
              auth: { user: 'admin', pass: 'admin' },
              params: { format: 'html' },
              method: 'GET',
              headers: { 'Content-Type' => 'application/json' }).body) do
  its(['auth.azuread', 'enabled']) { should eq 'true' }
  its(['auth.azuread', 'name']) { should eq 'Test Azure AD' }
  its(['auth.azuread', 'allow_sign_up']) { should eq 'true' }
  its(['auth.azuread', 'client_id']) { should eq 'test_id' }
  its(['auth.azuread', 'client_secret']) { should eq '*********' }
  its(['auth.azuread', 'auth_url']) { should eq 'https://login.microsoftonline.com/12345/oauth2/authorize' }
  its(['auth.azuread', 'token_url']) { should eq 'https://login.microsoftonline.com/12345/oauth2/token' }
  its(['auth.azuread', 'scopes']) { should eq 'openid email name groups' }
  its(['auth.azuread', 'allowed_domains']) { should eq 'test.local' }
  its(['auth.azuread', 'allowed_groups']) { should eq '12345' }
end
