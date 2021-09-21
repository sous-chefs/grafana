# Cookbook:: grafana
# Library:: _utils
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

require_relative '_utils'
require_relative 'grafana_config_file'
require_relative 'ldap_config_file'

module Grafana
  module Cookbook
    module ConfigHelper
      include Grafana::Cookbook::GrafanaConfigFile
      include Grafana::Cookbook::LdapConfigFile
      include Grafana::Cookbook::Utils

      GLOBAL_CONFIG_PROPERTIES_SKIP = %i(conf_directory config_file load_existing_config_file cookbook source source_ldap source_env owner group filemode sensitive extra_options).freeze
      private_constant :GLOBAL_CONFIG_PROPERTIES_SKIP

      private

      # Enumerate the properties of the including resource
      # Properties are skipped globally via the constant GLOBAL_CONFIG_PROPERTIES_SKIP
      # Properties are skipped per-resource via the :resource_config_properties_skip method if it is defined
      #
      # @return [Array] list of resource properties
      #
      def resource_properties
        properties = instance_variable_defined?(:@new_resource) ? new_resource.class.properties(false).keys : self.class.properties(false).keys
        Chef::Log.debug("resource_properties: Got properties from resource: #{properties.join(', ')}")
        properties.reject! { |p| GLOBAL_CONFIG_PROPERTIES_SKIP.include?(p) }

        if respond_to?(:resource_config_properties_skip)
          Chef::Log.debug("resource_properties: Resourced defined skip properties: #{resource_config_properties_skip.join(', ')}")
          properties.reject! { |p| resource_config_properties_skip.include?(p) }
        end

        Chef::Log.info("resource_properties: Filtered properties: #{properties.join(', ')}")
        properties
      end

      # Add/remove/overwrite/delete accumulator config values
      #
      # @param action [Symbol] Config action to perform
      # @param key [String, Symbol] The key to manipulate
      # @param value [any] Value to assign to key
      # @return [nil]
      #
      def accumulator_config(action, key, value = nil)
        path = if respond_to?(:resource_config_path_override)
                 raise ArgumentError, 'Path override should be specified as an Array' unless resource_config_path_override.is_a?(Array)
                 resource_config_path_override
               else
                 resource_default_config_path
               end

        config_hash = accumulator_config_path_init(*path)
        Chef::Log.debug("Perfoming action #{action} on config key #{key}, value [#{value.class}] #{value} on path #{path.map { |p| "['#{p}']" }.join}")

        case action
        when :set
          config_hash[key.to_s] = value
        when :append
          config_hash[key.to_s] ||= ''
          config_hash[key.to_s].concat(value.to_s)
        when :push
          config_hash[key.to_s] ||= []
          config_hash[key.to_s].push(value)
        when :delete
          config_hash.delete(key.to_s) if config_hash.key?(key.to_s)
        else
          raise ArgumentError, "Unsupported accumulator config action #{action}"
        end
      end

      # Check if a given configuration file template resource exists
      #
      # @return [true, false]
      #
      def config_template_exist?
        Chef::Log.debug("config_template_exist?: Checking for config file template #{new_resource.config_file}")
        config_resource = !find_resource!(:template, ::File.join(new_resource.config_file)).nil?

        Chef::Log.debug("config_template_exist?: #{config_resource}")
        config_resource
      rescue Chef::Exceptions::ResourceNotFound
        Chef::Log.debug("config_template_exist?: Config file template #{new_resource.config_file} ResourceNotFound")
        false
      end

      # Initialise a configuration file template resource
      #
      # @return [true, false] Template creation result
      #
      def init_config_template
        return false if config_template_exist?

        Chef::Log.info("init_config_template: Creating config template resource for #{new_resource.config_file}")

        config_variables = if new_resource.load_existing_config_file
                             load_method = new_resource.config_file.match?('grafana.ini') ? :load_file_grafana_config : :load_file_ldap_config
                             Chef::Log.debug("init_config_template: Loading existing config file #{new_resource.config_file} into template variables via #{load_method}")

                             existing_config_load = send(load_method, new_resource.config_file) || {}
                             Chef::Log.debug("init_config_template: Existing config load data: #{existing_config_load}")

                             existing_config_load
                           else
                             {}
                           end

        with_run_context(:root) do
          declare_resource(:chef_gem, 'deepsort') { compile_time true } unless gem_installed?('deepsort')
          declare_resource(:chef_gem, 'inifile') { compile_time true } unless gem_installed?('inifile')
          declare_resource(:chef_gem, 'toml-rb') { compile_time true } unless gem_installed?('toml-rb')

          declare_resource(:template, ::File.join(new_resource.config_file)) do
            source new_resource.source
            cookbook new_resource.cookbook

            owner new_resource.owner
            group new_resource.group
            mode new_resource.filemode

            sensitive new_resource.sensitive

            variables(config: config_variables)

            helpers(Grafana::Cookbook::IniHelper)
            helpers(Grafana::Cookbook::TomlHelper)

            action :nothing
            delayed_action :create
          end
        end

        true
      end

      # Initialise a Hash path for a configuration file template resources variables
      #
      # @param *path [String, Symbol, Array<String>, Array<Symbol>] The path to initialise
      # @return [Hash] The initialised Hash object
      #
      def accumulator_config_path_init(*path)
        init_config_template unless config_template_exist?

        return config_file_template_variables if path.all? { |p| p.is_a?(NilClass) } # Root path specified
        return config_file_template_variables.dig(*path) if config_file_template_variables.dig(*path).is_a?(Hash) # Return path if it exists

        Chef::Log.debug("accumulator_config_path_init: Initialising config file #{new_resource.config_file} path config#{path.map { |p| "['#{p}']" }.join}")
        config_hash = config_file_template_variables
        path.each do |pn|
          config_hash[pn] ||= {}
          config_hash = config_hash[pn]
        end

        config_hash
      end

      # Return the relevant configuration file template resources variables configuration key
      #
      # @return [Hash] Config template variables
      #
      def config_file_template_variables
        init_config_template unless config_template_exist?
        find_resource!(:template, ::File.join(new_resource.config_file)).variables[:config]
      end

      # Return a configured LDAP host from the on-disk file
      #
      # @return [Hash] The LDAP server configuration Hash
      #
      def ldap_server_config(host)
        template_servers = config_file_template_variables.fetch('servers', nil)
        template_server_index = template_servers.find_index { |s| s['host'].eql?(host) } if template_servers

        unless template_servers && template_server_index
          Chef::Log.info("No server configuration found, got [#{template_servers.class}] #{template_servers}") unless template_servers
          Chef::Log.info("No index found for host #{host}, got [#{template_server_index.class}] #{template_server_index}") unless template_server_index

          return
        end

        template_servers[template_server_index]
      end

      # Check if a resource property translation alias is defined and return the original property name
      # If an alias is not defined return the original property name
      #
      # @return [String] The (translated if required) property name
      #
      def translate_property_key(value)
        return resource_config_properties_translate.key(value) if respond_to?(:resource_config_properties_translate) &&
                                                                  resource_config_properties_translate.value?(value)

        value.to_s
      end

      # Check if a resource property translation alias is defined and return the translated config property name
      # If an alias is not defined return the original property name
      #
      # @return [String] The (translated if required) config property name
      #
      def translate_property_value(key)
        return resource_config_properties_translate.fetch(key) if respond_to?(:resource_config_properties_translate) &&
                                                                  resource_config_properties_translate.key?(key)

        key.to_s
      end
    end
  end
end
