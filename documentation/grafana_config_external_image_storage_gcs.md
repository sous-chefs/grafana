[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_external_image_storage_gcs

Configures the external_image_storage.gcs section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#external_image_storagegcs>.

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                    | Type        | Default | Description                                                                                            | Allowed Values |
| ----------------------- | ----------- | ------- | ------------------------------------------------------------------------------------------------------ | -------------- |
| `key_file`              | String      |         | Optional path to JSON key file associated with a Google service account to authenticate and authorize. |                |
| `bucket`                | String      |         | Bucket Name on Google Cloud Storage.                                                                   |                |
| `path`                  | String      |         | Optional extra path inside bucket.                                                                     |                |
| `enable_signed_urls`    | True, False |         | If set to true, Grafana creates a signed URL for the image uploaded to Google Cloud Storage.           | true, false    |
| `signed_url_expiration` | String      |         | Sets the signed URL expiration, which defaults to seven days.                                          |                |
