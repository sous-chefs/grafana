module GrafanaCookbook
  module ConfigHelper
    CONFIG_PROPERTIES_SKIP = %i(instance_name).freeze

    def nil_or_empty?(*values)
      values.any? { |v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
    end

    def resource_properties
      new_resource.class.state_properties.map { |p| p.options[:name] }
    end

    def run_state_config_set(key, value, *path_override)
      path = path_override.empty? ? resource_config_path : path_override

      config_hash = run_state_config_path_init(*path)
      Chef::Log.debug("Setting config key #{key}, value #{value} on path node.run_state['sous-chefs']#{path.map { |p| "['#{p}']" }.join}")

      config_hash[key] = value
    end

    def run_state_config_push(key, value, *path_override)
      path = path_override.empty? ? resource_config_path : path_override

      config_hash = run_state_config_path_init(*path)
      Chef::Log.debug("Pushing config key #{key}, value #{value} on path node.run_state['sous-chefs']#{path.map { |p| "['#{p}']" }.join}")

      config_hash[key] ||= []
      config_hash[key].push(value)
    end

    private

    def resource_config_path
      config_path = Array(new_resource.instance_name)
      config_path.concat(new_resource.declared_type.to_s.delete_prefix('grafana_').split('_'))

      config_path
    end

    def run_state_config_path_init(*path)
      node.run_state['sous-chefs'] ||= {}

      return node.run_state['sous-chefs'].dig(*path) if node.run_state['sous-chefs'].dig(*path).is_a?(Hash)

      Chef::Log.debug("Initialising config path node.run_state['sous-chefs']#{path.map { |p| "['#{p}']" }.join}")
      config_hash = node.run_state['sous-chefs']
      path.each do |pn|
        config_hash[pn] ||= {}
        config_hash = config_hash[pn]
      end

      config_hash
    end
  end
end
