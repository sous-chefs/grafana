# frozen_string_literal: true

describe file('/etc/grafana/grafana.ini') do
  its('content') { should match /allow_loading_unsigned_plugins = my-test-plugin/ }
end
