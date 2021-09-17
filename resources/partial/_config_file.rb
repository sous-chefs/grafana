#
# Cookbook:: grafana
# Resource:: _config_file
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

include Grafana::Cookbook::ConfigHelper
include Grafana::Cookbook::GrafanaConfigFile

unified_mode true

property :sensitive, [true, false],
          default: true,
          desired_state: false

property :conf_directory, String,
          default: '/etc/grafana',
          desired_state: false

property :config_file, String,
          default: lazy { ::File.join(conf_directory, 'grafana.ini') },
          desired_state: false

property :load_existing_config_file, true,
          default: true,
          desired_state: false

property :cookbook, String,
          default: 'grafana',
          desired_state: false

property :source, String,
          default: 'grafana.ini.erb',
          desired_state: false

property :owner, String,
          default: 'root'

property :group, String,
          default: 'grafana'

property :filemode, String,
          default: '0640'

property :extra_options, Hash,
          coerce: proc { |p| p.transform_keys(&:to_s) }

load_current_value do |new_resource|
  current_config = load_file_grafana_config_section(new_resource.config_file)

  current_value_does_not_exist! if nil_or_empty?(current_config)

  if ::File.exist?(new_resource.config_file)
    owner ::Etc.getpwuid(::File.stat(new_resource.config_file).uid).name
    group ::Etc.getgrgid(::File.stat(new_resource.config_file).gid).name
    filemode ::File.stat(new_resource.config_file).mode.to_s(8)[-4..-1]
  end

  extra_options_filtered = current_config.reject { |k, _| resource_properties.include?(k.to_sym) }
  current_config.reject! { |k, _| extra_options_filtered.keys.include?(k) }

  resource_properties.each do |p|
    next unless current_config.fetch(p.to_s, nil)

    send(p, current_config.fetch(p.to_s))
  end

  extra_options(extra_options_filtered) unless nil_or_empty?(extra_options_filtered)
end

action_class do
  include Grafana::Cookbook::ConfigHelper
  include Grafana::Cookbook::GrafanaConfigFile
end

action :create do
  converge_if_changed do
    resource_properties.each do |rp|
      next if nil_or_empty?(new_resource.send(rp))

      accumulator_config(:set, rp, new_resource.send(rp))
    end

    new_resource.extra_options.each { |key, value| accumulator_config(:set, key, value) } if property_is_set?(:extra_options)
  end
end

action :delete do
  set_properties = resource_properties.push(:extra_options).filter { |rp| property_is_set?(rp) }
  delete_properties = if nil_or_empty?(set_properties)
                        resource_properties
                      else
                        set_properties
                      end
  diff_properties = delete_properties.filter { |dp| load_file_grafana_config_section(new_resource.config_file).key?(dp.to_s) }

  if property_is_set?(:extra_options)
    extra_options_diff = new_resource.extra_options.keys.filter { |eo| load_file_grafana_config_section(new_resource.config_file).key?(eo) }
    diff_properties.concat(extra_options_diff) unless nil_or_empty?(extra_options_diff)
  end

  converge_by("Deleting configuration for #{diff_properties.join(', ')}") do
    diff_properties.each { |rp| accumulator_config(:delete, rp) }
  end unless diff_properties.empty?
end
