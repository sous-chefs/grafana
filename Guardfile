guard 'foodcritic', cookbook_paths: '.' do
  watch(%r{^attributes\/(.+)\.rb})
  watch(%r{^libraries\/(.+)\.rb})
  watch(%r{^recipes\/(.+)\.rb})
  watch('metadata.rb')
end

guard 'rubocop' do
  watch(%r{^attributes\/(.+)\.rb})
  watch(%r{^libraries\/(.+)\.rb})
  watch(%r{^recipes\/(.+)\.rb})
  watch('metadata.rb')
end

guard :rspec, cmd: 'rspec --color' do
  watch(%r{^libraries\/(.+)\.rb})
  watch(%r{^spec\/(.+)_spec\.rb})
  watch(%r{^recipes\/(.+)\.rb}) { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
end
