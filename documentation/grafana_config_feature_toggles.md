
[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_feature_toggles

Configures the feature toggles section of the configuration <https://grafana.com/docs/grafana/latest/administration/feature-toggles/>

Introduced: v10.0.0

## Actions

- None

## Properties

| Name     | Type        | Default | Description                            | Allowed Values |
| -------- |-------------|--------|----------------------------------------|----------------|
| `enable` | string, Array|
| `alertingPreviewUpgrade` | true, false | `true`  | Enable/disable unified alert in the UI | true, false    |
| `angularDeprecationUI`   | true, false | `false` | Enable/disable the notification in UI panels that angular will be decommissioned | true, false |
| `panelTitleSearch`       | true, false | `true`  | Enable/disable search for a dashboard by the title of a panel that appears in a dashboard | true, false |
## Examples

```ruby
grafana_config_feature_toggles 'grafana'
```

```ruby
grafana_config_feature_toggles 'grafana' do
  alertingPreviewUpgrade 'false'
  angularDeprecationUI 'false'
  panelTitleSearch 'true'
end
```
