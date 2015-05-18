guard 'foodcritic', cookbook_paths: '.', all_on_start: false do
  watch(%r{/attributes\/.+\.rb$/})
  watch(%r{/recipes\/.+\.rb$/})
  watch(%r{/libraries\/.+\.rb$/})
  watch('metadata.rb')
end

guard 'rubocop', all_on_start: false do
  watch(%r{/attributes\/.+\.rb$/})
  watch(%r{/recipes\/.+\.rb$/})
  watch(%r{/libraries\/.+\.rb$/})
  watch('metadata.rb')
end

# guard :rspec do
#   watch(/^libraries\/(.+)\.rb$/)
#   watch(/^spec\/(.+)_spec\.rb$/)
#   watch(/^(recipes)\/(.+)\.rb$/)   { |m| "spec/#{m[1]}_spec.rb" }
#   watch('spec/spec_helper.rb')      { 'spec' }
# end
