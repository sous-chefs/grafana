require ::File.expand_path('../../spec_helper', __FILE__)

describe file('/usr/sbin/grafana-server') do
  it { should be_a_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/init.d/grafana-server') do
  it { should be_a_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/default/grafana-server') do
  it { should be_a_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/grafana/grafana.ini') do
  it { should be_a_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('grafana-server') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/nginx/sites-enabled/grafana') do
  it { should be_file }
  it { should be_linked_to '/etc/nginx/sites-available/grafana' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /server 127.0.0.1:3000;/ }
  its(:content) { should match /proxy_pass http:\/\/grafana;/ }
end

describe command("curl http://127.0.0.1:3000/") do
  its(:stdout) { should match /<a href="\/login">Found<\/a>/ }
end

describe command("curl http://#{$ohaidata[:ipaddress]}:3000/") do
  its(:stderr) { should match /(Failed to|couldn't) connect/ }
end

describe command("curl http://#{$ohaidata[:ipaddress]}/") do
  its(:stdout) { should match /<a href="\/login">Found<\/a>/ }
end
