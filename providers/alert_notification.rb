require 'chef/mash'

include GrafanaCookbook::AlertingApi
include GrafanaCookbook::OrganizationApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  # If alert notification name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.alert_notification.key?(:name)
    new_resource.alert_notification[:name] = new_resource.name
  end

  _select_org(new_resource, grafana_options)

  alert_notifications = get_alerting_notification_list(grafana_options)
  exists = false

  alert_notifications.each do |src|
    exists = true if src['name'] == new_resource.alert_notification[:name]
    break if exists
  end

  # If not found, let's create it
  unless exists
    converge_by("Creating alert notification #{new_resource.alert_notification[:organization]} #{new_resource.alert_notification[:name]}") do
      add_alerting_notification(new_resource.alert_notification, _legacy_http_semantic, grafana_options)
    end
  end
end

action :update do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  # If alert notification name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.alert_notification.key?(:name)
    new_resource.alert_notification[:name] = new_resource.name
  end

  _select_org(new_resource, grafana_options)

  alert_notifications = get_alerting_notification_list(grafana_options)
  exists = false

  # Check wether we have to update alert notification's login
  old_name = if new_resource.alert_notification[:name] != new_resource.name
               new_resource.name
             else
               new_resource.alert_notification[:name]
             end

  # Find wether alert notification already exists
  # If found, update all informations we have to
  alert_notifications.each do |src|
    if src['name'] == old_name
      exists = true
      new_resource.alert_notification[:id] = src['id']
      converge_by("Updating alert notification #{new_resource.alert_notification[:name]}") do
        update_alerting_notification(new_resource.alert_notification, _legacy_http_semantic, grafana_options)
      end
    end
    break if exists
  end
end

action :delete do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.admin_user,
    password: new_resource.admin_password
  }
  # If alert notification name is not provided as variable,
  # Let's use resource name for it
  unless new_resource.alert_notification.key?(:name)
    new_resource.alert_notification[:name] = new_resource.name
  end

  _select_org(new_resource, grafana_options)

  alert_notifications = get_alerting_notification_list(grafana_options)
  exists = false

  # Find wether alert notification already exists
  # If found, delete it
  alert_notifications.each do |src|
    if src['name'] == new_resource.alert_notification[:name]
      exists = true
      new_resource.alert_notification[:id] = src['id']
      converge_by("Deleting alert notification #{new_resource.name}") do
        delete_alerting_notification(new_resource.alert_notification, grafana_options)
      end
    end
  end
end

def _legacy_http_semantic
  return false if node['grafana']['version'] == 'latest'
  Gem::Version.new(node['grafana']['version']) < Gem::Version.new('2.0.3')
end

def _check_org!(alert_notification, orgs)
  return if orgs.length <= 1 || alert_notification.key?(:organization)
  raise 'More then one organization, so organization is mandatory for a alert notification'
end

def _select_org(new_resource, grafana_options)
  # check, if we have multiple orgs, then the org is mandatory
  orgs = get_orgs_list(grafana_options)
  _check_org! new_resource.alert_notification, orgs

  # don't do anything if an organization is not selected
  return unless new_resource.alert_notification.key?(:organization)

  # Find organization by name
  selected_org = orgs.detect do |org|
    org['name'] == new_resource.alert_notification[:organization]
  end

  # If organization is provided select it
  unless selected_org
    raise "Could not find organization #{new_resource.alert_notification[:organization]}"
  end
  select_org(selected_org, grafana_options)
end
