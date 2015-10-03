if defined?(ChefSpec)
  # Data Source matchers
  def create_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :create, name)
  end

  def create_grafana_datasource_if_missing(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :create_if_missing, name)
  end
  def delete_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :delete, name)
  end

  # Dashboard matchers
  def create_grafana_dashboard(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_dashboard, :create, name)
  end
  def create_grafana_dashboard_if_missing(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_dashboard, :create_if_missing, name)
  end
  def delete_grafana_dashboard(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_dashboard, :delete, name)
  end

  # Organization matchers
  def create_grafana_organization(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_organization, :create, name)
  end

  def update_grafana_organization(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_organization, :update, name)
  end

  def delete_grafana_organization(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_organization, :delete, name)
  end

  # User matchers
  def create_grafana_user_if_missing(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_user, :create_if_missing, name)
  end
end
