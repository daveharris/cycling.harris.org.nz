source "https://rubygems.org"

gem "rails", "~> 8.0.2"

gem "sqlite3", ">= 2.1"

gem "puma", ">= 5.0"
gem "thruster", require: false

gem "importmap-rails"
gem "propshaft"
gem "stimulus-rails"
gem "turbo-rails"

gem "bootsnap", require: false

gem "kamal", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
end

group :development do
  gem "web-console"
end
