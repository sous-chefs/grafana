name 'grafana'
maintainer 'Jonathan Tron'
maintainer_email 'jonathan@tron.name'
license 'Apache 2.0'
description 'Installs/Configures grafana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.4'

%w(git nginx ark).each do |cb|
  depends cb
end

supports 'ubuntu'
supports 'debian'
