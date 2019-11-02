grafana_install 'Grafana'
grafana_config 'Grafana'
grafana_config_auth 'Grafana' do
  # for api testing
  anonymous_enabled true
end

grafana_config_writer 'Grafana'

grafana_plugin 'grafana-clock-panel' do
  action :install
end
