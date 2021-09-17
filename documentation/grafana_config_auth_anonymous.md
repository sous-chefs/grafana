[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_auth_anonymous

Configures the auth.anonymous section of the configuration <https://grafana.com/docs/grafana/latest/auth/grafana/#anonymous-authentication>

Introduced: v10.0.0

## Actions

- `:create`
- `:delete`

## Properties

| Name            | Type        | Default | Description                                                                                               | Allowed Values |
| --------------- | ----------- | ------- | --------------------------------------------------------------------------------------------------------- | -------------- |
| `:enabled`      | True, False | `false` | Enable AzureAD Auth                                                                                       | true, false    |
| `:org_name`     | String      |         | Organization name that should be used for unauthenticated user                                            |                |
| `:org_role`     | String      |         | Role for unauthenticated users, other valid values are `Editor` and `Admin`                               |                |
| `:hide_version` | True, False |         | Hide the Grafana version text from the footer and help tooltip for unauthenticated users (default: false) | true, false    |
