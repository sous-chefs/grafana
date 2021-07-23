# Tests are failing as the server has not fully become available when tests run
chef_sleep 'Sleep so inspec tests pass' do
  seconds 25
  not_if { ::File.exist? '/root/.slept' }
end
file '/root/.slept'
