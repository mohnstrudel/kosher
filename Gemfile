source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Let's get the errors
gem 'rollbar'

# Nifty gem for placeholder images
gem 'placeholdit'

# Гем для того, что бы склонять русские название
gem "petrovich"
gem 'savon'
gem 'translit'
gem 'russian'

# For nice json api
gem 'active_model_serializers', require: true

# For translated fields
gem 'globalize', github: 'globalize/globalize'
gem 'activemodel-serializers-xml'
gem 'globalize-accessors'


# Switching back to custom jQuery again after failing builds
# gem 'jquery-rails'

# Use Devise for handling users
gem 'devise'

# Use HAML for a nice html markup
gem "haml-rails"

# Use font awesome and Glyphicons
gem "font-awesome-rails"
gem 'bootstrap-glyphicons'

# Use this gem for nice slugs in URLs
gem 'friendly_id'

gem 'faker'

gem 'figaro'
gem 'curb'

gem 'will_paginate'

# Use CKEditor for html formatting
gem 'bootsy' # Screw CKEditor, it's not working on production! 
gem 'carrierwave' # Required for images upload using ckeditor and in general
gem 'mini_magick' # Required for image processing

# Рассылка писем
gem 'gibbon'
gem 'delayed_job_active_record'

# что бы юзать yarn
gem 'webpacker'

# Что бы как-то нагрузку смягчить
gem 'rack-attack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # For testing internationalization
  gem 'i18n-tasks'
  # i18n end
  
  
  
  gem 'launchy'
  gem 'database_cleaner'
  # To test render_template
  gem 'rails-controller-testing'
  gem 'factory_girl_rails'
  
  gem 'pry'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper' # <- New!
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  
  # Better error interface with this gem
  # gem "better_errors"

  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
  gem 'capistrano-nvm', require: false
  gem 'capistrano-yarn'

  gem 'capistrano-figaro-yml'

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
