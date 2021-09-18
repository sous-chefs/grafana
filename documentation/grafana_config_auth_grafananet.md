[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_grafananet

Configures the auth.grafananet section of the configuration <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name                     | Type        | Default | Description                                                                            | Allowed Values |
| ------------------------ | ----------- | ------- | -------------------------------------------------------------------------------------- | -------------- |
| `:enabled`               | True, False | `false` | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet> | true, false    |
| `:allow_sign_up`         | True, False |         | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet> | true, false    |
| `:client_id`             | String      |         | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet> |                |
| `:client_secret`         | String      |         | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet> |                |
| `:scopes`                | String      |         | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet> |                |
| `:allowed_organizations` | String      |         | <https://grafana.com/docs/grafana/latest/administration/configuration/#authgrafananet> |                |
