
include_recipe "git"

git "#{node['grafana']['install_dir']}/#{node['grafana']['git']['branch']}" do
  repository node['grafana']['git']['url']
  reference node['grafana']['git']['branch']
  case  node['grafana']['git']['type']
  when "checkout"
    action :checkout
  when "sync"
    action :sync
  end
  user grafana_user
end

link "#{node['grafana']['install_dir']}/current" do
  to "#{node['grafana']['install_dir']}/#{node['grafana']['git']['branch']}"
end

node.set['grafana']['web_dir'] = "#{node['grafana']['install_dir']}/current/src"
