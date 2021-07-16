[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_dataproxy

Configures the core dataproxy section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

`:install`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `logging`                 | true, false   | `false`                     | This enables data proxy logging                        | true, false

## Examples

```ruby
grafana_config_dataproxy 'grafana'
```

```ruby
grafana_config_dataproxy 'grafana' do
  logging true
end
```
