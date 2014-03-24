
include_recipe "git"

git "#{node['grafana']['install_dir']}/#{node['grafana']['git']['branch']}" do
  repository node['grafana']['git']['url']
  reference node['grafana']['git']['branch']
  action node['grafana']['git']['type'].to_s
  user grafana_user
end

link "#{node['grafana']['install_dir']}/current" do
  to "#{node['grafana']['install_dir']}/#{node['grafana']['git']['branch']}"
end
