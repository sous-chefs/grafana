name 'grafana'
maintainer 'Jonathan Tron'
maintainer_email 'jonathan@tron.name'
license 'Apache 2.0'
description 'Installs/Configures grafana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.3'

supports 'ubuntu', '>= 12.04'
supports 'debian', '>= 7.0'
supports 'centos', '>= 6.4'

recipe 'grafana::default', 'Installs and configures Grafana with a web server proxy'

depends 'apt'
depends 'yum'
depends 'nginx'
