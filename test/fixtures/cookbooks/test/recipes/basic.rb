grafana_install 'grafana'

grafana_config 'Grafana' do
  # In test we turn of sensitive so we can get better logs
  sensitive false
end

grafana_service 'grafana' do
  action %i(enable start)
end
