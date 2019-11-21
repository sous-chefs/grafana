[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_folder

This resource will allow you to create global folder within Grafana. This resource is minimally viable and only supports the addition of global non-admin users. Contribution to the functionality would be appreciated.

More information about creating Grafana folder via the HTTP API can be found [here](http://docs.grafana.org/http_api/folder/#folder-api).

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
| `folder`              |  Hash       |               | A Hash of the values to create the folder. Examples below.|

## Examples

Assuming you would like to create a new folder...

```ruby
grafana_folder 'grafana' do
  folder(
    title: 'grafana'
  )
  action :create
end
```

Folder's title property is not mandatory. Default goes to resource name.
The default action is also to create folder.

To update folder's details

```ruby
grafana_user 'old_name' do
  folder(
    overwrite: true,
    title: 'new_name'
  )
  action :update
end
```

Folder's overwrite property is not mandatory but stongly recommended

The permission works as follow:

Viewer: "Permission": 1
Editor: "Permission": 2
Admin:  "Permission": 4

```ruby
grafana_user 'old_name' do
  folder(
    overwrite: true,
    title: 'new_name',
    permissions: {
      items: [
        {
          "role": "Viewer",
          "permission": 1
        },
        {
          "role": "Editor",
          "permission": 2
        },
        {
          "teamId": 1,
          "permission": 1
        },
        {
          "userId": 11,
          "permission": 4
        }
      ]
    }
  )
  action :update
end
```

Folder's overwrite property is not mandatory but stongly recommended
More information about Grafana folder's permission via the HTTP API can be found [here](http://docs.grafana.org/http_api/folder_permissions/).

And finally to delete a folder

```ruby
grafana_user 'grafana' do
  action :delete
end
```
