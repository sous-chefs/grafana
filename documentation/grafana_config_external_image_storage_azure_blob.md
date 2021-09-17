[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_external_image_storage_azure_blob

Configures the external_image_storage.azure_blob section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#external_image_storageazure_blob>.

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name             | Type   | Default | Description                                                                                                                                              | Allowed Values |
| ---------------- | ------ | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| `account_name`   | String |         | Storage account name                                                                                                                                     |                |
| `account_key`    | String |         | Storage account key                                                                                                                                      |                |
| `container_name` | String |         | Container name where to store “Blob” images with random names. Creating the blob container beforehand is required. Only public containers are supported. |                |
