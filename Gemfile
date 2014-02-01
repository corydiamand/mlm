source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bcrypt-ruby', '3.0.1'
gem 'activemodel'
gem 'will_paginate', '3.0.3'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'fog', '~> 1.3.1'
gem 'aws-sdk'
gem 'carrierwave'
gem 'dotenv-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'newrelic_rpm' 

group :development, :test do
  gem 'rspec-rails', '~> 2.12.0'
  gem 'guard-rspec', '1.2.1'
  gem 'pry-rails'
end

group :development do
  gem 'annotate', '2.5.0'
  gem 'quiet_assets'
end
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'
  gem 'morrisjs-rails'
  gem 'raphael-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end



group :test do
  gem 'capybara', '2.0.2'
  gem 'rb-fsevent', '0.9.1', :require => false
  gem 'growl', '1.0.3'
  gem 'guard-spork', '1.4.1'
  gem 'spork', '0.9.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'poltergeist'
  gem 'launchy'
  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'pg'
  ruby '1.9.3'
  gem 'unicorn'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
