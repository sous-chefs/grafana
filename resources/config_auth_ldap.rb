# Cookbook:: grafana
# Resource:: config_auth_ldap
#
# Copyright:: 2021, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unified_mode true

use 'partial/_config_file'

property :enabled, [true, false],
          default: false

property :ldap_config_file, String,
          default: '/etc/grafana/ldap.toml'

property :allow_sign_up, [true, false]

load_current_value do |new_resource|
  current_config = load_file_grafana_config_section(new_resource.config_file)

  current_value_does_not_exist! if nil_or_empty?(current_config)

  if ::File.exist?(new_resource.config_file)
    owner ::Etc.getpwuid(::File.stat(new_resource.config_file).uid).name
    group ::Etc.getgrgid(::File.stat(new_resource.config_file).gid).name
    filemode ::File.stat(new_resource.config_file).mode.to_s(8)[-4..-1]
  end

  resource_properties.each { |p| send(p.to_s.delete_prefix('ldap_').to_sym, current_config.fetch(p.to_s.delete_prefix('ldap_'), nil)) }
end

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s.delete_prefix('ldap_'), new_resource.send(rp))
  end
end
