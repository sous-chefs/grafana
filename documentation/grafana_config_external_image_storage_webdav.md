# grafana_config_external_image_storage_webdav

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the external_image_storage.webdav section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#external_image_storagewebdav>.

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name         | Type   | Default | Description                                                                                                                                                                                                                                   | Allowed Values |
| ------------ | ------ | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| `url`        | String |         | URL where Grafana sends PUT request with images.                                                                                                                                                                                              |                |
| `username`   | String |         | Basic auth username.                                                                                                                                                                                                                          |                |
| `password`   | String |         | Basic auth password.                                                                                                                                                                                                                          |                |
| `public_url` | String |         | Optional URL to send to users in notifications. If the string contains the sequence ${file}, it is replaced with the uploaded filename. Otherwise, the file name is appended to the path part of the URL, leaving any query string unchanged. |                |
