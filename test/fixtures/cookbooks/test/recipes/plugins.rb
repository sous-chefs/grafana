grafana_install 'Grafana'
grafana_config 'Grafana'

grafana_config_auth_anonymous 'Grafana' do
  enabled true # for api testing
end

grafana_plugin 'grafana-clock-panel' do
  action :install
end

grafana_plugin 'yesoreyeram-boomtable-panel' do
  plugin_url 'https://raw.githubusercontent.com/sous-chefs/grafana/master/test/fixtures/cookbooks/test/files/plugin-test.zip'
  action :update
end

grafana_service 'grafana-server' do
  action %i(enable start)
  subscribes :restart, 'template[/etc/grafana/grafana.ini]', :delayed
end
