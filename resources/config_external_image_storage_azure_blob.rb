#
# Cookbook:: grafana
# Resource:: config_external_image_storage_azure_blob
#
# Copyright:: 2018, Sous Chefs
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
# Configures the installed grafana instance

unified_mode true

use 'partial/_config_file'

property :account_name, String

property :account_key, String

property :container_name, String

load_current_value do |new_resource|
  current_config = load_file_grafana_config_section(new_resource.config_file, 'external_image_storage.azure_blob')

  current_value_does_not_exist! if nil_or_empty?(current_config)

  if ::File.exist?(new_resource.config_file)
    owner ::Etc.getpwuid(::File.stat(new_resource.config_file).uid).name
    group ::Etc.getgrgid(::File.stat(new_resource.config_file).gid).name
    filemode ::File.stat(new_resource.config_file).mode.to_s(8)[-4..-1]
  end

  resource_properties.each { |p| send(p, current_config.fetch(p.to_s, nil)) }
end

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp), 'external_image_storage.azure_blob')
  end
end
