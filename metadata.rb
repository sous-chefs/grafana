name 'grafana'
maintainer 'Andrei Skopenko'
maintainer_email 'andrei@skopenko.net'
license 'Apache-2.0'
description 'Installs/Configures Grafana Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.2.0'
source_url 'https://github.com/sous-chefs/chef-grafana'
issues_url 'https://github.com/sous-chefs/chef-grafana/issues'

chef_version '>= 11.0'

supports 'ubuntu', '>= 12.04'
supports 'debian', '>= 7.0'
supports 'centos', '>= 6.4'

recipe 'grafana::default', 'Installs and configures Grafana with a web server proxy'

depends 'apt'
depends 'yum'
depends 'chef_nginx'
