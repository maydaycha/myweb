source 'http://rubygems.org'
ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3'
end


group :production do
  # gem 'pg', '~> 0.17.0'
  # for heroku
  gem 'rails_12factor'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

gem 'bootstrap_form'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'mysql2'

# ActiveRecord session
#gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

gem "recaptcha", :require => "recaptcha/rails"

gem 'certified'
# gem 'thin'


gem 'oauth'
gem 'omniauth'
gem 'omniauth-facebook','1.4.0'
gem "omniauth-google-oauth2", "~> 0.2.1"
gem 'omniauth-weibo-oauth2'
gem 'omniauth-linkedin'


gem 'devise'
# gem 'devise_security_extension'
gem 'devise-encryptable'
gem 'bcrypt'

# gem 'country_select'
gem 'localized_country_select', '>= 0.9.8'
gem 'carmen-rails'
# gem 'nokogiri' # for get country from CLDR

gem 'i18n-timezones'
gem 'i18n-country-translations'

gem "spreadsheet"

gem 'kaminari'

# Captcha
gem 'easy_captcha'

gem 'formtastic_i18n', '~> 0.1.1'

# admin
gem 'activeadmin', github: 'activeadmin'
# github: 'activeadmin'
# gem "meta_search",    '>= 1.1.0.pre'

gem 'localeapp'

group :development, :test do
  gem 'faker'
end

group :development, :test do
  gem 'guard'
  gem 'guard-rspec', require: false
end

group :development, :test do
  gem 'guard-livereload', require: false
  gem "rack-livereload"
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end

group :development, :test do
  gem 'factory_girl_rails'
end

gem 'grape'

gem 'grape-entity'

gem 'mailboxer'

# gem 'ya2yaml'
