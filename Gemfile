source "https://rubygems.org"

ruby "3.0.2"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "sprockets-rails"
gem "importmap-rails"
gem "jbuilder"

gem "pg", "~> 1.1"
gem 'strong_migrations'

gem "puma", ">= 5.0"
gem "bootsnap", require: false

gem "turbo-rails"
gem "stimulus-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "figaro"
  gem 'rspec-rails', '~> 6.1.0'
end

group :development do
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

