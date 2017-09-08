source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# JavaScript library
gem 'jquery-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'

# Skip 5.10.2 due to https://github.com/seattlerb/minitest/issues/689
gem 'minitest', '~> 5.10', '!= 5.10.2'

# CSS Framework
gem 'bulma-rails', '~> 0.5.1'

# Text Icons
gem 'font-awesome-rails'

# Authentication Framework
gem 'devise'

# Adds invite functionality to Devise
gem 'devise_invitable'

# CRON-like Sidekiq Jobs
gem 'sidekiq-cron'

# Send slack notifications
gem 'slack-notifier'

# Validating URLS
gem 'validate_url'

# State Machine
gem 'aasm'

# Sending HTTP requests
gem 'httparty'

# Javascript Charting Library
gem 'chartjs-ror'

# Healthcheck Endpoint
gem 'okcomputer'

# Authorization Library
gem 'pundit'

group :development, :test do
  # Debugging
  gem 'byebug', platform: :mri

  # Code linting
  gem 'rubocop', require: false

  # Mock HTTP requests
  gem 'webmock'

  # File-based relational database
  gem 'sqlite3'

  # Pundit policy testing library
  gem 'policy-assertions'
end

group :production do
  # Postgres
  gem 'pg'

  # Sentry exception handling
  gem 'sentry-raven'

  # Rack HTTP server
  gem 'unicorn'

  # Instrument app using https://skylight.io
  gem 'skylight'
end

group :test do
  # Report metrics to CodeClimate
  gem 'codeclimate-test-reporter', '~> 1.0.0'

  # Makes ActiveSupport::TestCase to utilize the MiniTest::Spec::DSL
  gem 'minitest-spec-rails'

  # Mocking and stubbing library
  gem 'mocha'

  # Brings back `assigns` and `assert_template`
  gem 'rails-controller-testing'

  # Provides line coverage reports
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.1.5'
  gem 'web-console', '>= 3.3.0'

  # ruby web server built for concurrency
  gem 'puma'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
