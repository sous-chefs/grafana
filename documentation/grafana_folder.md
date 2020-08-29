[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_folder

This resource will allow you to create a global folder within Grafana. This resource is minimally viable and only supports the addition of global non-admin users. Contribution to the functionality would be appreciated.

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
| `url_path_prefix`     |  String     | nil           | The url_path_prefix grafana is available from when running behind the proxy (ex. '/grafana')|
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

Folder's title property is not mandatory. Defaults to resource name.
The default action is also to create folder.

To update folder's details

```ruby
grafana_folder 'old_name' do
  folder(
    overwrite: true,
    version: 1,
    title: 'new_name'
  )
  action :update
end
```

Folder's overwrite property is not mandatory. Defaults to true if version is not specified.
Folder's version property is not mandatory.

The permission works as follow:

Viewer: "Permission": 1
Editor: "Permission": 2
Admin:  "Permission": 4

```ruby
grafana_folder 'old_name' do
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

More information about Grafana folder's permission via the HTTP API can be found [here](http://docs.grafana.org/http_api/folder_permissions/).

And finally to delete a folder

```ruby
grafana_folder 'grafana' do
  action :delete
end
```
