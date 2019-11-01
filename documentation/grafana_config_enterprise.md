[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_enterprise

Configures the core enterprise section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

`:create`

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
