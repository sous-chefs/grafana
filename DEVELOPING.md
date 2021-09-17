# Developing

The refactor of the cookbooks in v10 makes some major changes to the underlying method of operation of the cookbook to improve operation and maintainabilty.

In summary:

- Accumulator config hash initialisation is automatic upon initial access
- Accumulator config hash paths are automatically generated from the resource name
- Property enumeration is automatic so adding a property to resource will result in that property being added to the configuration Hash
- Most config resource functionality has been moved to the partially-abstract `_config_file` and `_config_file_ldap` partial resources
  - Barring edge cases, all `config_*` resources inherit from these partials and contain only their properties
  - `load_current_value` has been implemented for all resources
- The `extra_options` hash property has been added to allow the additional of arbitrary configuration options (all config resources)
- Config files are now generated by the `inifile` and `toml-rb` gems so the templates are purely placeholders

## Adding a new configuration item to an existing resource

Adding a new configuration item to an existing resource is as simple as adding the required item as a property to resource representing the section of the configuration file.

## Adding a new configuration section

To add a new configuration section a `config_` resource should be created where the name following the `config_` prefix is the name of the configuration section to represent. Configuration items under the section are then added as properties to this resource.

The configuration resource **must** then inherit from the `_config_base` partial template via the addition of

```ruby
use 'partial/_config_file'
```

At the top of the resource declaration above the first property.

See a pre-existing resource for an example of this pattern.

### Overiding the automatic path

If the name of the resource cannot match the name of the configuration section or a nested configuration section is in use such as `section.subsection` then the automatic configuration path can be overriden by the addition of the `resource_config_path_override` method. Due to needed to override the path in both the action class and the outer resource class this method must be added to both sections of the resource declaration.

Below the last property add the following with the array contents set to the config Hash path set as you would path to [Hash#dig](https://ruby-doc.org/core-3.0.2/Hash.html#method-i-dig) to create the (nested if required) configuration path.

```ruby
def resource_config_path_override
  %w(external_image_storage.s3)
end

action_class do
  def resource_config_path_override
    %w(external_image_storage.s3)
  end
end
```

### Excluding properties from the configuration

If an additional property must be added for the resource to operation but the property is not relevant for the Grafana config file then these properties can be marked to be skipped by the enumerator method but the creation of a `resource_config_properties_skip` method. This method should be added to the action class only.

```ruby
def resource_config_properties_skip
  %i(host)
end
```