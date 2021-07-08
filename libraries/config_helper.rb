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

      config_hash[key] ||= ''
      config_hash[key].concat(value.to_s)

      init_config_writer
    end

    def run_state_config_push(key, value, *path_override)
      path = path_override.empty? ? resource_config_path : path_override

      config_hash = run_state_config_path_init(*path)
      Chef::Log.debug("Pushing config key #{key}, value #{value} on path node.run_state['sous-chefs']#{path.map { |p| "['#{p}']" }.join}")

      config_hash[key] ||= []
      config_hash[key].push(value)

      init_config_writer
    end

    private

    def config_writers_exist?
      (nil_or_empty?(node.run_state.dig('sous-chefs', new_resource.instance_name, 'config')) || !find_resource!(:template, ::File.join(new_resource.config_file)).nil?) &&
        (nil_or_empty?(node.run_state.dig('sous-chefs', new_resource.instance_name, 'ldap')) || !find_resource!(:template, ::File.join(new_resource.config_file_ldap)).nil?)
    rescue Chef::Exceptions::ResourceNotFound
      false
    end

    def init_config_writer
      return false if config_writers_exist?

      Chef::Log.debug("Run state content: #{node.run_state}")

      declare_resource(:chef_gem, 'inifile') do
        compile_time true
      end

      declare_resource(:template, ::File.join(new_resource.config_file)) do
        source new_resource.source
        cookbook new_resource.cookbook

        owner new_resource.owner
        group new_resource.group
        mode new_resource.filemode

        sensitive new_resource.sensitive

        variables(
          grafana: node.run_state.dig('sous-chefs', new_resource.instance_name, 'config')
        )

        action :nothing
        delayed_action :create
      end unless nil_or_empty?(node.run_state.dig('sous-chefs', new_resource.instance_name, 'config'))

      declare_resource(:template, ::File.join(new_resource.config_file_ldap)) do
        source new_resource.source_ldap
        cookbook new_resource.cookbook

        owner new_resource.owner
        group new_resource.group
        mode new_resource.filemode

        sensitive new_resource.sensitive

        variables(
          ldap: node.run_state.dig('sous-chefs', new_resource.instance_name, 'ldap')
        )

        action :nothing
        delayed_action :create
      end unless nil_or_empty?(node.run_state.dig('sous-chefs', new_resource.instance_name, 'ldap'))
    end

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
