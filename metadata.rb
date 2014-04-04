name 'grafana'
maintainer 'Jonathan Tron'
maintainer_email 'jonathan@tron.name'
license 'Apache 2.0'
description 'Installs/Configures grafana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.1'

%w{git nginx}.each do |cb|
  depends cb
end
depends 'ark', '>= 0.7.2'

supports 'ubuntu'
supports 'debian'
