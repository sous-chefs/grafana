default['grafana']['ldap_verbose_logging'] = false

default['grafana']['ldap']['[servers]']['host'] = {
  comment: 'Ldap server host',
  disable: false,
  value: '"127.0.0.1"',
}
default['grafana']['ldap']['[servers]']['port'] = {
  comment: 'Default port is 389 or 636 if use_ssl = true',
  disable: false,
  value: 389,
}
default['grafana']['ldap']['[servers]']['use_ssl'] = {
  comment: 'Set to true if ldap server supports TLS',
  disable: false,
  value: false,
}
default['grafana']['ldap']['[servers]']['ssl_skip_verify'] = {
  comment: 'set to true if you want to skip ssl cert validation',
  disable: false,
  value: false,
}
default['grafana']['ldap']['[servers]']['bind_dn'] = {
  comment: 'Search user bind dn',
  disable: false,
  value: '"cn=admin,dc=grafana,dc=org"',
}
default['grafana']['ldap']['[servers]']['bind_password'] = {
  comment: 'Search user bind password',
  disable: false,
  value: 'grafana',
}
default['grafana']['ldap']['[servers]']['search_filter'] = {
  comment: 'Search filter, for example "(cn=%s)" or "(sAMAccountName=%s)"',
  disable: false,
  value: '"(cn=%s)"',
}
default['grafana']['ldap']['[servers]']['search_base_dns'] = {
  comment: 'An array of base dns to search through',
  disable: false,
  value: ['dc=grafana,dc=org'],
}
default['grafana']['ldap']['servers.attributes'] = {
  name: { value: '"givenName"' },
  surname: { value: '"sn"' },
  username: { value: '"cn"' },
  member_of: { value: '"memberOf"' },
  email: { value: '"email"' },
}
default['grafana']['ldap']['[servers.group_mappings]'] = [
  {
    group_dn: {
      comment: 'Map ldap groups to grafana org roles',
      disable: false,
      value: '"cn=admins,dc=grafana,dc=org"',
    },
    org_role: {
      disable: false,
      value: '"Admin"',
    },
    org_id: {
      comment: 'The Grafana organization database id, optional, ' \
               'if left out the default org (id 1) will be used',
      disable: true,
      value: 1,
    },
  },
  {
    group_dn: {
      disable: false,
      value: '"cn=users,dc=grafana,dc=org"',
    },
    org_role: {
      disable: false,
      value: '"Editor"',
    },
  },
  {
    group_dn: {
      comment: 'If you want to match all (or no ldap groups) then you can use wildcard',
      disable: false,
      value: '"*"',
    },
    org_role: {
      disable: false,
      value: '"Viewer"',
    },
  },
]
