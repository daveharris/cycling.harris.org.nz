source 'https://rubygems.org'

ruby '2.1.4'

gem 'rails', '~> 4.1.7'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'bootstrap-datepicker-rails'
gem 'font-awesome-sass'

gem 'chronic_duration'
gem 'smarter_csv'
gem 'strava-api-v3', '~> 0.0.8'
gem 'nokogiri', '~> 1.6.5'

gem 'clearance'

gem 'thin'

gem 'raygun4ruby'

group :development do
  gem 'spring'
  gem 'better_errors', '~> 2.0.0'
  gem 'binding_of_caller', platforms: [:mri_21]
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'launchy'
end
