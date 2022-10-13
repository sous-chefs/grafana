def sys_dir
  os[:family] =~ /redhat|fedora/ ? 'sysconfig' : 'default'
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

describe toml('/etc/grafana/ldap.toml') do
  its(['servers', 0, 'host']) { should eq '127.0.0.1' }
  its(['servers', 0, 'port']) { should eq 389 }
  its(['servers', 0, 'use_ssl']) { should eq false }
  its(['servers', 0, 'start_tls']) { should eq false }
  its(['servers', 0, 'ssl_skip_verify']) { should eq false }

  its(['servers', 0, 'bind_dn']) { should eq 'cn=admin,dc=grafana,dc=org' }
  its(['servers', 0, 'bind_password']) { should eq 'SuperSecretPassword' }

  its(['servers', 0, 'search_filter']) { should eq '(cn=%s)' }
  its(['servers', 0, 'search_base_dns', 0]) { should eq 'dc=grafana,dc=org' }

  its(['servers', 0, 'attributes', 'name']) { should eq 'givenName' }
  its(['servers', 0, 'attributes', 'surname']) { should eq 'sn' }
  its(['servers', 0, 'attributes', 'username']) { should eq 'cn' }
  its(['servers', 0, 'attributes', 'member_of']) { should eq 'memberOf' }
  its(['servers', 0, 'attributes', 'email']) { should eq 'email' }

  its(['servers', 0, 'group_mappings', 0, 'group_dn']) { should eq 'cn=admins,dc=grafana,dc=org' }
  its(['servers', 0, 'group_mappings', 0, 'org_role']) { should eq 'Admin' }
  its(['servers', 0, 'group_mappings', 0, 'org_id']) { should eq 1 }
  its(['servers', 0, 'group_mappings', 0, 'grafana_admin']) { should eq true }

  its(['servers', 0, 'group_mappings', 2, 'group_dn']) { should eq '*' }
  its(['servers', 0, 'group_mappings', 2, 'org_role']) { should eq 'Viewer' }
  its(['servers', 0, 'group_mappings', 2, 'org_id']) { should eq 1 }
  its(['servers', 0, 'group_mappings', 2, 'grafana_admin']) { should eq false }

  its(['servers', 0, 'group_mappings', 3, 'group_dn']) { should eq 'cn=readers,dc=grafana,dc=org' }
  its(['servers', 0, 'group_mappings', 3, 'org_role']) { should eq 'Viewer' }
  its(['servers', 0, 'group_mappings', 3, 'org_id']) { should eq 1 }
  its(['servers', 0, 'group_mappings', 3, 'grafana_admin']) { should eq false }
end

describe file('/etc/grafana/ldap.toml') do
  its('content') { should_not match /cn=admins,ou=groups,dc=grafana,dc=org/ }
  its('content') { should_not match /cn=users,ou=groups,dc=grafana,dc=org/ }
  its('content') { should match /group_dn = "\*"/ }
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
  its(['auth.ldap', 'enabled']) { should eq 'true' }
end
