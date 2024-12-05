source 'https://rubygems.org'

ruby '3.0.2'

gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

gem 'importmap-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'sprockets-rails'

gem 'pg', '~> 1.5', '>= 1.5.9'
gem 'strong_migrations'

gem 'bootsnap', require: false
gem 'puma', '>= 5.0'

# gem 'bootstrap', '~> 5.3.2'
gem 'sassc-rails'
gem 'slim-rails', '~> 3.6.2'
gem 'stimulus-rails'
gem 'turbo-rails'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'
gem 'rails-i18n'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'figaro'
  gem 'rubocop', '~> 1.40', require: false
  gem 'rubocop-performance', '~> 1.15', require: false
  gem 'rubocop-rails', '~> 2.17', require: false
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop-rspec', '~> 2.16.0', require: false
  gem 'selenium-devtools', '~> 0.122'
end

group :development do
  gem 'pry', '~> 0.14.2'
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end

gem 'rack-attack', '~> 6.7'
