# grafana_config_explore

[back to resource list](https://github.com/sous-chefs/grafana#resources)

Configures the core explore section of the configuration <http://docs.grafana.org/installation/configuration/>

Introduced: v4.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                      | Type          |  Default                    | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------- | ------------------------------------------------------------------------- | --------------- |
| `enabled`                 | true, false   | `false`                     | Enable the Explore section                                                | true, false

## Examples

```ruby
grafana_config_explore 'grafana'
```

```ruby
grafana_config_explore 'grafana' do
  enabled true
end
```
