# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use SCSS for stylesheets
gem 'sass-rails'

# Compressor for JavaScript assets
gem 'uglifier'

# JavaScript library
gem 'jquery-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'

# JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis'

# Skip 5.10.2 due to https://github.com/seattlerb/minitest/issues/689
gem 'minitest'

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

# Healthcheck Endpoint
gem 'okcomputer'

# Authorization Library
gem 'pundit'

# Charting Library
gem 'chartkick'

# Allows grouping temporal data
gem 'groupdate'

# Create time tags usable for jQuery Timeago plugin
gem 'rails-timeago', '~> 2.0'

# Avatar
gem 'gravtastic'

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
  # Makes ActiveSupport::TestCase to utilize the MiniTest::Spec::DSL
  gem 'minitest-spec-rails'

  # Mocking and stubbing library
  gem 'mocha'

  # Brings back `assigns` and `assert_template`
  gem 'rails-controller-testing'

  # Provides line coverage reports
  gem 'simplecov', require: false

  gem 'capybara'
  gem 'poltergeist'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'web-console'

  # ruby web server built for concurrency
  gem 'puma'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
