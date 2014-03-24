case node['grafana']['file']['type']
when "zip"
  include_recipe 'ark::default'
  ark 'grafana' do
    url node['grafana']['file']['url']
    path node['grafana']['install_path']
    checksum  node['grafana']['file']['checksum']
    owner grafana_user
    strip_leading_dir false
    action :put
  end
end
