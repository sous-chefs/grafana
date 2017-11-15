
def get_rpm_version(version)
  return "#{version}-1" if Gem::Version.new(version) <= Gem::Version.new('3.0.1')
  version
end
