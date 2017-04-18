source 'https://rubygems.org'

gem 'berkshelf', '~> 4.0'
gem 'emeril'
gem 'rake'

group :test do
  gem 'chefspec', '~> 4.4.0'
  gem 'foodcritic', '~> 5.0.0'
  gem 'rubocop', '~> 0.31'
end

group :integration do
  gem 'kitchen-vagrant'
  gem 'test-kitchen'
end

group :development do
  gem 'guard'
  gem 'guard-foodcritic'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rb-readline'
end
