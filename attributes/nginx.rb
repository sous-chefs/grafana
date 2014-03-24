default['grafana']['nginx']['template'] = 'grafana-nginx.conf.erb'
default['grafana']['nginx']['template_cookbook'] = 'grafana'

include_attribute 'nginx'

default['nginx']['enable_default_site'] = false
