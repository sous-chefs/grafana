[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_user

This resource will allow you to create global users within Grafana. This resource is minimally viable and only supports the addition of global non-admin users. Contribution to the functionality would be appreciated.

More information about creating Grafana users via the HTTP API can be found at [docs.grafana.org/reference/http_api](http://docs.grafana.org/reference/http_api/#users).

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
| `user`                | Hash        | `{}`          | A Hash of the values to create the user. Examples below.|

## Examples

Assuming you would like to create a new user...

```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test123',
    isAdmin: true
  )
  action :create
end
```

User's login property is not mandatory. Default goes to resource name.

To update user's details, password and permissions

```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test1234',
    isAdmin: false
  )
  action :update
end
```

To update user's login, use current login as resource name and new login as user property, like:

```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    login: 'john.smith',
    email: 'test@example.com',
    password: 'test1234',
    isAdmin: false
  )
  action :update
end
```

To add j.smith to 'Org. 1' as Admin and to 'Org. 2' as Viewer

```ruby
grafana_user 'j.smith' do
  user(
    name: 'John Smith',
    email: 'test@example.com',
    password: 'test123',
    isAdmin: true,
    organizations: [
      { name: 'Org. 1', role: 'Admin' },
      { name: 'Org. 2', role: 'Viewer' }
    ]
  )
  action :create
end
```

To remove j.smith from Org. 2

```ruby
grafana_user 'j.smith' do
  user(
    organizations: [
      { name: 'Org. 2', role: 'DELETE' }
    ]
  )
  action :update
end
```

And finally to delete a user

```ruby
grafana_user 'john.smith' do
  action :delete
end
```
