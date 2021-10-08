source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 6.0.4.1'

# App server
gem 'puma', '~> 4.1'

# Database
gem 'pg', '>= 0.18', '< 2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '5.4.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times
gem 'bootsnap', '>= 1.4.2', require: false

# Authentication
gem 'sorcery'

# Serializer
gem 'fast_jsonapi'

# UI/UX
gem 'rails-i18n', '~> 6.0.0'
gem 'enum_help'
gem 'kaminari'
gem 'ransack'

group :development, :test do
  # Code analyze
  gem 'rubocop', '~> 1.22', require: false
  gem 'rubocop-rails', require: false

  # Debugger
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'

  # Print debug
  gem 'hirb'
  gem 'hirb-unicode-steakknife'

  # Security analysis
  gem 'brakeman'
  gem 'bundler-audit'

  # Test
  gem 'rspec-rails', '~> 5.0.0'
  gem 'factory_bot_rails'

  gem 'rubyzip', '~> 2.3.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'

  # CLI
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Table/Schema
  gem 'annotate'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
