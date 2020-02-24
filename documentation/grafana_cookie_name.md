[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_cookie_name

If you set a custom cookie name, this should defined prior to creating any grafana cookbook resources.  This will ensure that those other resources use your custom cookie name, and not the default.  `grafana_cookie_name` isn't a resource, but is really a custom dsl definition.  However, you reference this custom dsl the same as a resource.  To use this, please specifiy the cookie name as `grafana_cookie_name 'cookie_name'`

If you are using the `grafana_install` resource and a version of Grafana prior to 6.0.0, it will automatically set the cookie name to the legacy value of `grafana_sess`.  You would not have to manually define `grafana_cookie_name` at that point

Introduced: v8.5.0

## Actions

No actions as this is a custom dsl, not a resource.  The cookie name defaults across all of this cookbooks resources will be set to the name you specify

## Properties

None

## Examples

```ruby
grafana_cookie_name 'custom_cookie_name'
```
