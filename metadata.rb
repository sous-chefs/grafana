name             'grafana'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Installs/Configures Grafana Server'
source_url       'https://github.com/sous-chefs/grafana'
issues_url       'https://github.com/sous-chefs/grafana/issues'
chef_version     '>= 15.5'
version          '9.7.1'

supports 'ubuntu', '>= 12.04'
supports 'debian', '>= 7.0'
supports 'centos', '>= 6.4'

recipe 'grafana::default', 'Installs and configures Grafana with a web server proxy'

depends 'apt'
depends 'yum'
depends 'nginx'
