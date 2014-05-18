default['grafana']['install_type'] = "git" # git | file
default['grafana']['git']['url'] = "https://github.com/torkelo/grafana"
default['grafana']['git']['branch'] = "master"
default['grafana']['git']['type'] = "sync" # checkout | sync
default['grafana']['file']['type'] = "zip" # zip
default['grafana']['file']['version'] = '1.5.4'
f = node['grafana']['file']
default['grafana']['file']['url'] = "http://grafanarel.s3.amazonaws.com/grafana-#{f['version']}.#{f['type']}"
default['grafana']['file']['checksum'] = "fee7334efba967142955be2fa39ecae7bca0cc9b7a76c301430746be4fc7ec6d" # sha256 ( shasum -a 256 FILENAME )
default['grafana']['webserver'] = "nginx"
default['grafana']['install_path'] = "/opt"
default['grafana']['install_dir'] = "#{node['grafana']['install_path']}/grafana"
case node['grafana']['install_type']
when 'git'
  default['grafana']['web_dir'] = "#{node['grafana']['install_dir']}/current/src"
when 'file'
  default['grafana']['web_dir'] = node['grafana']['install_dir']
end
default['grafana']['es_server'] = "127.0.0.1"
default['grafana']['es_port'] = "9200"
default['grafana']['es_role'] = "elasticsearch_server"
default['grafana']['es_scheme'] = "http://"
default['grafana']['es_user'] = ''
default['grafana']['es_password'] = ''
default['grafana']['graphite_server'] = "127.0.0.1"
default['grafana']['graphite_port'] = "80"
default['grafana']['graphite_role'] = "graphite_server"
default['grafana']['graphite_scheme'] = "http://"
default['grafana']['graphite_user'] = ''
default['grafana']['graphite_password'] = ''
default['grafana']['user'] = ''
default['grafana']['config_template'] = 'config.js.erb'
default['grafana']['config_cookbook'] = 'grafana'
default['grafana']['webserver_hostname'] = node.name
default['grafana']['webserver_aliases'] = [node['ipaddress']]
default['grafana']['webserver_listen'] = node['ipaddress']
default['grafana']['webserver_port'] = 80
default['grafana']['webserver_scheme'] = "http://"
default['grafana']['timezone_offset'] = "null" # Example: "-0500" (for UTC - 5 hours)
