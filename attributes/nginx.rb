default['grafana']['nginx']['template'] = 'grafana-nginx.conf.erb'
default['grafana']['nginx']['template_cookbook'] = 'grafana'

include_attribute 'nginx'

default['nginx']['default_site_enabled'] = false
