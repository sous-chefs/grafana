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

# TODO: change URL to point to master after merging
grafana_plugin 'yesoreyeram-boomtable-panel' do
  plugin_url 'https://raw.githubusercontent.com/sous-chefs/grafana/feature/resources/test/fixtures/cookbooks/test/files/plugin-test.zip'
  action :update
end

# Tests are failing as the server has not fully become available when tests run
chef_sleep 'Sleep so inspec tests pass' do
  seconds 25
end
