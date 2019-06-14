grafana_install 'grafana'

grafana_config 'Grafana'
grafana_config_auth 'Grafana' do
  # for api testing
  anonymous_enabled true
end

grafana_plugin 'grafana-clock-panel' do
  action :install
end
