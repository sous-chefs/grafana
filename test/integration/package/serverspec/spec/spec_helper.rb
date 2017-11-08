require 'serverspec'
require 'ohai'

set :backend, :exec

ohai = Ohai::System.new
ohai.all_plugins
