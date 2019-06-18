describe command('grafana-cli plugins ls') do
  its(:stdout) { should include 'grafana-clock-panel' }
end
