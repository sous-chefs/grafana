require 'serverspec'
set :backend, :exec

def sys_dir
  return 'sysconfig' if os[:family] =~ /redhat/
  'default'
end
