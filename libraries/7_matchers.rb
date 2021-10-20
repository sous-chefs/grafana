if defined?(ChefSpec)
  # Alerting notifications matchers
  def create_grafana_alert_notification(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_alert_notification, :create, name)
  end
  def update_grafana_alert_notification(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_alert_notification, :update, name)
  end
  def delete_grafana_alert_notification(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_alert_notification, :delete, name)
  end
  # Provisioning feature
  def create_grafana_provisioning_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_provisioning_datasource, :create, name)
  end
  def create_grafana_provisioning_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_provisioning_datasource, :update, name)
  end
  def create_grafana_provisioning_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_provisioning_datasource, :delete, name)
  end
  # Data Source matchers
  def create_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :create, name)
  end

  def update_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :update, name)
  end

  def delete_grafana_datasource(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_datasource, :delete, name)
  end

  # Dashboard matchers
  def create_grafana_dashboard(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_dashboard, :create, name)
  end

  def update_grafana_dashboard(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_dashboard, :update, name)
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
  def create_grafana_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_user, :create, name)
  end

  def update_grafana_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_user, :update, name)
  end

  def delete_grafana_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:grafana_user, :delete, name)
  end

  # Plugin matchers
  def plugin_install_cmd(name)
    ChefSpec::Matchers::ResourceMatcher.new(:build_cli_cmd, name, :install)
  end

  def plugin_update_cmd(name)
    ChefSpec::Matchers::ResourceMatcher.new(:build_cli_cmd, name, :update)
  end

  def plugin_remove_cmd(name)
    ChefSpec::Matchers::ResourceMatcher.new(:build_cli_cmd, name, :remove)
  end
end
