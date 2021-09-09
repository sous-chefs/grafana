module Grafana
  module Cookbook
    module Utils
      private

      def nil_or_empty?(*values)
        values.any? { |v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
      end

      def gem_installed?(gem_name)
        !Gem::Specification.find_by_name(gem_name).nil?
      rescue Gem::LoadError
        false
      end

      def resource_default_config_path
        type_string = instance_variable_defined?(:@new_resource) ? new_resource.declared_type.to_s : resource_name.to_s
        config_path = Array(type_string.gsub(/(grafana_)(config_)?/, '').split('_').join('.'))

        Chef::Log.debug("resource_default_config_path: Generated config path #{config_path}")
        raise if nil_or_empty?(config_path)

        config_path
      end
    end
  end
end
