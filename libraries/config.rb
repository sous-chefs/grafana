module Grafana
  module Cookbook
    module ConfigHelper
      GLOBAL_CONFIG_PROPERTIES_SKIP = %i(conf_directory config_file cookbook source source_ldap source_env owner group filemode sensitive extra_options).freeze
      private_constant :GLOBAL_CONFIG_PROPERTIES_SKIP

      private

      def nil_or_empty?(*values)
        values.any? { |v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
      end

      def resource_properties
        properties = new_resource.class.properties(false).keys
        Chef::Log.debug("resource_properties: Got properties from resource: #{properties.join(', ')}")
        properties.reject! { |p| GLOBAL_CONFIG_PROPERTIES_SKIP.include?(p) }

        if respond_to?(:resource_config_properties_skip)
          Chef::Log.debug("resource_properties: Resourced defined skip properties: #{resource_config_properties_skip.join(', ')}")
          properties.reject! { |p| resource_config_properties_skip.include?(p) }
        end

        Chef::Log.info("resource_properties: Filtered properties: #{properties.join(', ')}")
        properties
      end

      def accumulator_config(action, key, value, *path_override)
        path = nil_or_empty?(path_override) ? resource_default_config_path : path_override

        config_hash = accumulator_config_path_init(*path)
        Chef::Log.debug("Append to config key #{key}, value #{value} on path #{path.map { |p| "['#{p}']" }.join}")

        case action
        when :set
          config_hash[key] = value
        when :append
          config_hash[key] ||= ''
          config_hash[key].concat(value.to_s)
        when :push
          config_hash[key] ||= []
          config_hash[key].push(value)
        else
          raise ArgumentError, "Unsupported config action #{action}"
        end
      end

      def config_template_exist?
        Chef::Log.debug("config_template_exist?: Checking for config file #{new_resource.config_file}")
        config_resource = !find_resource!(:template, ::File.join(new_resource.config_file)).nil?

        Chef::Log.debug("config_template_exist?: #{config_resource}")
        config_resource
      rescue Chef::Exceptions::ResourceNotFound
        Chef::Log.info("config_template_exist?: Config file #{new_resource.config_file} ResourceNotFound")
        false
      end

      def init_config_template
        return false if config_template_exist?

        Chef::Log.debug("init_config_template: Creating config template resource for #{new_resource.config_file}")

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

            variables(
              config: {}
            )

            helpers(Grafana::Cookbook::IniHelper)
            helpers(Grafana::Cookbook::TomlHelper)

            action :nothing
            delayed_action :create
          end
        end

        true
      end

      def gem_installed?(gem_name)
        !Gem::Specification.find_by_name(gem_name).nil?
      rescue Gem::LoadError
        false
      end

      def config_file_template_variables
        init_config_template unless config_template_exist?
        find_resource!(:template, ::File.join(new_resource.config_file)).variables[:config]
      end

      def resource_default_config_path
        config_path = new_resource.declared_type.to_s.delete_prefix('grafana_config_').split('_')

        Chef::Log.debug("resource_default_config_path: Generated config path #{config_path}")
        config_path
      end

      def accumulator_config_path_init(*path)
        init_config_template unless config_template_exist?

        return config_file_template_variables if path.all? { |p| p.is_a?(NilClass) } # Root path specified
        return config_file_template_variables.dig(*path) if config_file_template_variables.dig(*path).is_a?(Hash) # Return path if existing

        Chef::Log.debug("accumulator_config_path_init: Initialising config file #{new_resource.config_file} path config#{path.map { |p| "['#{p}']" }.join}")
        config_hash = config_file_template_variables
        path.each do |pn|
          config_hash[pn] ||= {}
          config_hash = config_hash[pn]
        end

        config_hash
      end
    end
  end
end
