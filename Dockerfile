# Use the barebones version of Ruby 2.2.3.
FROM ruby:2.2.3-slim

MAINTAINER Allister Antosik <me@allisterantosik.com>

# Install dependencies
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev --fix-missing --no-install-recommends

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /juno
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
RUN bundle install --without development test

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# The default command that gets ran will be to start the Unicorn server.
CMD bundle exec unicorn -c config/unicorn.rb -E production
