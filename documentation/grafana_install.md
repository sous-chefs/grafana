# grafana_install

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Installs Grafana from the repositories, this will setup the correct apt/yum repo and install it, allows you to supply your own custom repository.

## Actions

- `:install`

## Properties

| Name               | Type          | Default                                                   | Description                                                        | Allowed Values |
| ------------------ | ------------- | --------------------------------------------------------- | ------------------------------------------------------------------ | -------------- |
| `package`          | String, Array | `['grafana']`                                             | Alter the installed package name (for Enterprise installs etc)     |
| `version`          | String        | `nil`                                                     | Use if you want to install a specific version (Must exist in repo) |
| `repo`             | String        | `https://packages.grafana.com/oss`                        | Base Repository                                                    |
| `key`              | String        | `https://packages.grafana.com/gpg.key`                    | GPG Key for Debian                                                 |
| `rpm_key`          | String        | `https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana` | GPG key for RPM                                                    |
| `deb_distribution` | String        | `stable`                                                  | Deb Distribution                                                   |
| `deb_components`   | Array         | `['main']`                                                | Deb Components                                                     |

## Notes

After install please create a `service` resource for `grafana-server` so it can restart on config changes

## Examples

Installs Latest Grafana from official repository:

```ruby
grafana_install 'grafana'

service 'grafana-server' do
  action [:enable, :start]
  subscribes :restart, ['template[/etc/grafana/grafana.ini]', 'template[/etc/grafana/ldap.toml]'], :delayed
end

```
