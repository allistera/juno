#!/bin/bash

export RAILS_ENV=production

echo Running Database Migrations
bundle exec rake db:migrate || bundle exec rake db:setup

echo Starting Unicorn Server
bundle exec unicorn -c config/unicorn.rb -E production
