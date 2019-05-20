[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_organization

This resource will allow you to create organizations within Grafana.

More information about creating Grafana organizations via the HTTP API can be found at <http://docs.grafana.org/reference/http_api/#organizations>.

## Actions

- `:create`
- `:update`
- `:delete`

## Properties

| Name                  | Type        |  Default      | Description                                               | Allowed Values
| --------------------- | ----------- | ------------- | --------------------------------------------------------- | --------------- |
| `host`                | String      | `localhost`   | The host grafana is running on|
| `port`                | Integer     | `3000`        | The port grafana is running on|
| `admin_user`          | String      | `admin`       | A grafana user with admin privileges|
| `admin_password`      | String      | `admin`       | The grafana user's password|
| `auth_proxy_header`   | String      | nil           | The HTTP authentication header used when `auth.proxy.enabled=true`. See [grafana_config_auth:proxy_header_name](grafana_config_auth.md)|
| `organization`        | Hash        | `{}`          | A Hash of the values to create the organization. Examples below.|

## Examples

Assuming you would like to create a new organization called `Second Org.`:

```ruby
grafana_organization 'Second Org.'
```

You can also update an existing organization (usefull to change the name of the default organization):

```ruby
grafana_organization 'Main Org.' do
  organization(
    name: 'Main Org 2.'
  )
  action :update
end
```

You will finally be able to delete an organization (WARNING: this change is _NOT_ supported in Grafana 2.1.3):

```ruby
grafana_organization 'Second Org.' do
  action :delete
end
```
