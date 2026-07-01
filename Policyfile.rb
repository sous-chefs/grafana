# frozen_string_literal: true

name 'grafana'

run_list 'test::default'

cookbook 'grafana', path: '.'
cookbook 'test', path: './test/fixtures/cookbooks/test'

named_run_list :azuread, 'test::azuread'
named_run_list :basic, 'test::basic'
named_run_list :config_plugins, 'test::config-plugins'
named_run_list :configure, 'test::configure'
named_run_list :default, 'test::default'
named_run_list :ldap, 'test::ldap'
named_run_list :plugins, 'test::plugins'
named_run_list :proxy, 'test::proxy'
