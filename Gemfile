source 'https://rubygems.org'
ruby "2.1.5" # specify a Ruby version

gem 'volt'

gem 'nokogiri'

# The following gem's are optional for themeing

# Twitter bootstrap
gem 'volt-bootstrap'

# Simple theme for bootstrap, remove to theme yourself.
gem 'volt-bootstrap-jumbotron-theme'

# User templates for login, signup, and logout menu.
gem 'volt-user-templates'

group :development do
  gem 'byebug'
  gem 'rubocop', require: false
end

group :test do
  gem 'rubocop-checkstyle_formatter', require: false
end

# Server for MRI
platform :mri do
  gem 'thin', '~> 1.6.0'
  gem 'bson_ext', '~> 1.9.0'
end
