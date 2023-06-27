# grafana_config_enterprise

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core enterprise section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `license_path`            | String        |                             | License File Path                                                         | Valid file path

## Examples

```ruby
grafana_config_enterprise 'grafana'
```

```ruby
grafana_config_enterprise 'grafana' do
  license_path '/etc/grafana/license'
end
```
