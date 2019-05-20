[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_dashboard

Dashboards in Grafana are always going to be incredibly specific to the application, but you may want to be able to create a new dashboard along with a newly provisioned stack. This resource assumes you have a static json file that displays the information that will be flowing from the newly created stack.

This resource currently makes an assumption that the name used in invocation matches the name of the dashboard. This will obviously have limitations, and could change in the future. More documentation on creating Grafana dashboards via the HTTP API can be found at <http://docs.grafana.org/reference/http_api/#dashboards>.

## Actions

- `:create`
- `:update`
- `:delete`

## Properties

| Name                  | Type        |  Default      | Description                                               | Allowed Values
| --------------------- | ----------- | ------------- | --------------------------------------------------------- | --------------- |
| `host`                |  String     | `localhost`   | The host grafana is running on|
| `port`                |  Integer    | `3000`        | The port grafana is running on|
| `admin_user`          |  String     | `admin`       | A grafana user with admin privileges|
| `admin_password`      |  String     | `admin`       | The grafana user's password|
| `auth_proxy_header`   | String      | nil           | The HTTP authentication header used when `auth.proxy.enabled=true`. See [grafana_config_auth:proxy_header_name](grafana_config_auth.md)|
| `dashboard`           |  Hash       |               | A Hash of the values to create the dashboard. Examples below.|

## Examples

Assuming you have a `files/default/simple-dashboard.json`:

```ruby
grafana_dashboard 'simple-dashboard'
```

If you'd like to use a `my-dashboard.json` with the title `"title": "Test Dash"`:

```ruby
grafana_dashboard 'test-dash' do
  dashboard(
    source: 'my-dashboard',
    overwrite: false
  )
end
```

If the dashboard you would like to import is already on disk with the title `"title": "On Disk Dash"`:

```ruby
grafana_dashboard 'on-disk-dash' do
  dashboard(
    path: '/opt/grafana/dashboards/local-dash.json'
  )
end
```

You can update a dashboard. For that, you have 2 options:

Use `create` action with `overwrite` dashboard property, like:

```ruby
grafana_dashboard 'on-disk-dash' do
  dashboard(
    path: '/opt/grafana/dashboards/local-dash.json',
    overwrite: true
  )
  action :create
end
```

Or use `update` action, which will force `overwrite` dashboard property to true:

```ruby
grafana_dashboard 'on-disk-dash' do
  dashboard(
    path: '/opt/grafana/dashboards/local-dash.json'
  )
  action :update
end
```

Finally, you can delete a dashboard:

```ruby
grafana_dashboard 'test-dash' do
  action :delete
end
```
