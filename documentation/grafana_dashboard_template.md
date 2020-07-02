[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_dashboard_template

Dashboards in Grafana are always going to be incredibly specific to the application, but you may want to be able to create a new dashboard along with a newly provisioned stack. This resource assumes you have a templated json file that displays the information that will be flowing from the newly created stack.

This resource currently makes the same assumptions that grafana_dashboard does since it uses that resource under the hood in combination with the template resource.

## Actions

- `:create`
- `:update`
- `:delete`

## Properties

| Name                  | Type        |  Default                  | Description                                               | Allowed Values
| --------------------- | ----------- | ------------------------- | --------------------------------------------------------- | --------------- |
| `host`                |  String     | `localhost`               | The host grafana is running on|
| `port`                |  Integer    | `3000`                    | The port grafana is running on|
| `admin_user`          |  String     | `admin`                   | A grafana user with admin privileges|
| `admin_password`      |  String     | `admin`                   | The grafana user's password|
| `auth_proxy_header`   |  String     | nil                       | The HTTP authentication header used when `auth.proxy.enabled=true`. See [grafana_config_auth:proxy_header_name](grafana_config_auth.md)|
| `template_path`       |  String     | `/etc/grafana/dashboards` | Location to store the templates on disk |
| `template_source`     |  String     |                           | Template path relative to cookbook |
| `template_vars`       |  Hash       | `{}`                      | Vars to be used inside the template |
| `template_cookbook`   |  String     |                           | Cookbook to find the template in |
| `organization`        |  String     | nil                       | Grafana organization to save the dashboard to (if specified) |
| `folder`              |  String     | nil                       | Grafana folder to save the dashboard to (if specified) |

## Examples

Assuming you have a `templates/simple-dashboard-template.json.erb`:

```ruby
grafana_dashboard_template 'sample-dashboard-template' do
  auth_proxy_header auth_header

  organization 'Sous-Chefs'
  folder 'StayOrganized2'

  template_source 'dashboards/sample-dashboard-template.json.erb'
  template_cookbook template[:cookbook]

  template_vars(
    random_walk: 'injected value'
  )

  action [:create, :update]
end
```
