module Grafana
  module Cookbook
    module ConfigHelper
      CONFIG_PROPERTIES_SKIP = %i(instance_name).freeze
      private_constant :CONFIG_PROPERTIES_SKIP

      private

      def nil_or_empty?(*values)
        values.any? { |v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
      end

      def resource_properties
        new_resource.class.state_properties.map { |p| p.options[:name] }
      end

      def accumulator_config_set(key, value, *path_override)
        path = nil_or_empty?(path_override) ? resource_config_path : path_override

        config_hash = accumulator_config_path_init(*path)
        Chef::Log.debug("Setting config key #{key}, value #{value} on path #{path.map { |p| "['#{p}']" }.join}")

        config_hash[key] ||= ''
        config_hash[key].concat(value.to_s)
      end

      def accumulator_config_push(key, value, *path_override)
        path = nil_or_empty?(path_override) ? resource_config_path : path_override

        config_hash = accumulator_config_path_init(*path)
        Chef::Log.debug("Pushing config key #{key}, value #{value} on path #{path.map { |p| "['#{p}']" }.join}")

        config_hash[key] ||= []
        config_hash[key].push(value)
      end

      def config_writers_exist?
        !find_resource!(:template, ::File.join(new_resource.config_file)).nil? && !find_resource!(:template, ::File.join(new_resource.config_file_ldap)).nil?
      rescue Chef::Exceptions::ResourceNotFound
        false
      end

      def init_config_writer
        return false if config_writers_exist?

        Chef::Log.debug("Run state content: #{node.run_state}")

        declare_resource(:chef_gem, 'inifile') do
          compile_time true
        end unless ini_gem_installed?

        declare_resource(:chef_gem, 'toml-rb') do
          compile_time true
        end unless toml_gem_installed?

        declare_resource(:template, ::File.join(new_resource.config_file)) do
          source new_resource.source
          cookbook new_resource.cookbook

          owner new_resource.owner
          group new_resource.group
          mode new_resource.filemode

          sensitive new_resource.sensitive

          helpers(
            Grafana::Cookbook::IniHelper
          )

          action :nothing
          delayed_action :create
        end

        declare_resource(:template, ::File.join(new_resource.config_file_ldap)) do
          source new_resource.source_ldap
          cookbook new_resource.cookbook

          owner new_resource.owner
          group new_resource.group
          mode new_resource.filemode

          sensitive new_resource.sensitive

          action :nothing
          delayed_action :create
        end

        true
      end

      def ini_gem_installed?
        !Gem::Specification.find_by_name('inifile').nil?
      rescue Gem::LoadError
        false
      end

      def toml_gem_installed?
        !Gem::Specification.find_by_name('toml-rb').nil?
      rescue Gem::LoadError
        false
      end

      def grafana_config_variables
        find_resource!(:template, ::File.join(new_resource.config_file)).variables
      end

      def ldap_config_variables
        find_resource!(:template, ::File.join(new_resource.config_file_ldap)).variables
      end

      def resource_config_path
        config_path = Array(new_resource.instance_name)
        config_path.concat(new_resource.declared_type.to_s.delete_prefix('grafana_').split('_'))

        Chef::Log.debug("resource_config_path: Generated config path #{config_path}")
        config_path
      end

      def accumulator_config_path_init(*path)
        init_config_writer unless config_writers_exist?

        return grafana_config_variables.dig(*path) if grafana_config_variables.dig(*path).is_a?(Hash)

        Chef::Log.debug("accumulator_config_path_init: Initialising config path grafana_config_variables #{path.map { |p| "['#{p}']" }.join}")
        config_hash = grafana_config_variables
        path.each do |pn|
          config_hash[pn] ||= {}
          config_hash = config_hash[pn]
        end

        config_hash
      end
    end
  end
end
