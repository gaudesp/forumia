source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.3'                                         # version cible Ruby

gem 'rails', '~> 8.0.2'                              # Rails 8.0.2 
gem 'pg', '~> 1.5.9'                                 # PostgreSQL adapter 
gem 'puma', '~> 6.6.0'                               # serveur web 
gem 'rake', '~> 13.0'
gem 'ffi', '>= 1.15.5'
gem "importmap-rails"

gem 'mime-types', '~> 3.6', '>= 3.6.2'
gem 'mime-types-data', '>= 3.2024'

# Asset pipeline
gem 'sass-rails', '~> 6.0.0'                         # SCSS 
gem 'turbo-rails', '2.0.13'                          # Turbo (Turbolinks remplacé) 
gem 'coffee-rails', '5.0.0'                          # CoffeeScript adapter 

gem 'jbuilder', '~> 2.13.0'                          # JSON DSL 

gem 'bootsnap', '~> 1.18.4', require: false          # accélération du boot

# UI & forms
gem 'select2-rails'
gem 'simple_form'
gem 'bootstrap'
gem 'jquery-rails', '~> 4.6.0'                       # jQuery 
gem 'font_awesome5_rails'

# Auth & notifications
gem 'devise', '~> 4.9.4'                             # authentification 
gem 'video_info'
gem 'countries', '< 4.0.0'

# Uploads & APIs
gem 'carrierwave', '~> 2.2'
gem 'cloudinary'
gem 'rest-client', '~> 2.1.0'                        # HTTP client 

# Pagination
gem 'will_paginate', '~> 4.0.1'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 7.1.1'
  gem 'capybara', '~> 3.40.0'                        # tests fonctionnels 
  gem 'selenium-webdriver', '~> 4.31.0'              # driver Selenium 
end

group :development do
  gem "mutex_m"    # Nécessaire pour spring-watcher-listen et autres
  gem "ostruct"    # Pour silencer les warnings de Cloudinary (Ruby 3.5+)
  gem 'web-console', '~> 4.2.1'
  gem 'listen', '~> 3.8'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # ...
end

gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
