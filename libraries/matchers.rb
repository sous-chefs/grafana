if defined?(ChefSpec)
  def create_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :create, name)
  end

  def create_grafana_datasource_if_missing(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :create_if_missing, name)
  end

  def delete_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :delete, name)
  end
end
