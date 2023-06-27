# grafana_config_external_image_storage_s3

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core external_image_storage section of the configuration [(https://grafana.com/docs/installation/configuration/#external-image-storage)](https://grafana.com/docs/installation/configuration/#external-image-storage). This resource sets AWS S3 as the external image storage.

Introduced: v4.0.3

## Actions

`:install`

## Properties

| Name                      | Type        |  Default                                  | Description                                               | Allowed Values
| ------------------------- | ----------- | ----------------------------------------- | --------------------------------------------------------- | --------------- |
| `storage_provider`        | String      | `s3`                                      | Set the provider here| s3
| `region`                  | String      |                                           | Set the AWS region | Any AWS region e.g `us-east-1`, `us-west-2` etc.
| `bucket`                  | String      |                                           | Set the S3 bucket name                     |
| `bucket_url`              | String      |                                           | Bucket URL for S3. AWS region can be specified within URL or defaults to ‘us-east-1’, e.g. - <https://grafana.s3.amazonaws.com/>    (for backward compatibility, only works when no bucket or region are configured)      |
| `path`                    | String      |                                           | Optional extra path inside bucket     | Valid path inside the S3 bucket
| `access_key`              | String      |                                           | Access key for the aws account to use. It should have permissions to run `s3:PutObject` and `s3:PutObjectAcl` actionson the S3 bucket. Works along with `secret_key`. If not specified IAM instance profile is used instead by default.| Valid AWS secret key
| `secret_key`              | String      |                                           | Secret key for the aws account to use. If not specified IAM instance profile is used instead by default.| Valid AWS access key

## Examples

```ruby
grafana_config_external_image_storage_s3 'grafana' do
  storage_provider 's3'
  region 'us-east-1'
  bucket 'grafana-image-store'
end
```
