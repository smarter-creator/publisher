source "https://rubygems.org"

# Rails version
gem "rails", "~> 7.1.1"

# Bundler for managing dependencies
gem "bundler", ">= 1.3.5"

# Rake for task management
gem "rake", ">= 0.9.6"

# Recurring Select Gem (currently at 4.0.0.rc1, but specifying the latest stable version if available)
gem "recurring_select", "~> 4.0.0.rc1"



# Thin web server (used in production)

# SASS/SCSS for styling (used in asset pipeline)
gem "sass-rails", "~> 6.0.0"

# Active Support
gem "activesupport", "7.1.5.1"
gem "puma"
gem "sqlite3", ">= 1.4"

gem 'matrix', '~> 0.4.2'

# ActiveRecord and related gems
gem "activerecord", "7.1.5.1"
gem "actionpack", "7.1.5.1"
gem "actionview", "7.1.5.1"
gem "actionmailer", "7.1.5.1"
gem "actioncable", "7.1.5.1"
gem "activemodel", "7.1.5.1"
gem "activejob", "7.1.5.1"
gem "activestorage", "7.1.5.1"
gem "rails-dom-testing", "2.2.0"
gem "rails-html-sanitizer", "1.6.2"
gem "bootsnap"
gem 'concurrent-ruby', '~> 1.2.0'
gem 'minitest', '~> 5.25'

# Sprockets for asset pipeline management (using version 3.5.2)
gem "sprockets", "4.2.2"
gem "sprockets-rails", "3.5.2"

# Other gems
gem "ice_cube", ">= 0.11"
gem "jquery-rails", "~> 4.6.0"
gem "sassc-rails", ">= 2.1.1"
gem "tzinfo", "~> 2.0.6"

# Testing dependencies
group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

# Development gems
group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [ :ruby ]
end

# Test gems
group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  
  # Use the latest stable version of RSpec
  gem 'rspec', '~> 3.10'
  gem 'rspec-rails', '~> 5.0'
end
