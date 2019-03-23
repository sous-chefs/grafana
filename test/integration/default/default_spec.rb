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
