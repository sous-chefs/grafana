grafana_install 'Grafana'

grafana_config 'Grafana'

grafana_config_paths 'Grafana'

grafana_config_plugins 'Grafana' do
  allow_loading_unsigned_plugins %w( my-test-plugin )
end

grafana_service 'grafana' do
  action %i(enable start)
end
