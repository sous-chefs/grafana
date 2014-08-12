name 'grafana'
maintainer 'Jonathan Tron'
maintainer_email 'jonathan@tron.name'
license 'Apache 2.0'
description 'Installs/Configures grafana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.3.2'

depends 'git'
depends 'ark', '>= 0.7.2'
depends 'nginx'

supports 'ubuntu'
supports 'debian'
