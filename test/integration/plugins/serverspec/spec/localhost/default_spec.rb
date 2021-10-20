require ::File.expand_path('../../spec_helper', __FILE__)

describe command('grafana-server -v') do
  its(:stdout) { should match /Version 4.6.3/ }
end

describe command('grafana-cli plugins ls') do
  its(:stdout) { should match /grafana-clock-panel/ }
  its(:stdout) { should match /raintank-worldping-app/ }
end
