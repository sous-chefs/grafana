describe command('grafana-cli plugins ls') do
  its(:stdout) { should include 'grafana-clock-panel' }
  its(:stdout) { should include 'yesoreyeram-boomtable-panel' }
end
