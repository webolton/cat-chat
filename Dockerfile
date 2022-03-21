# Use the official Ruby image from Docker Hub
# https://hub.docker.com/_/ruby

# [START cloudrun_rails_base_image]
# who cares
FROM ruby:2.7-buster
# [END cloudrun_rails_base_image]

# Define where the application should be inside the image
ENV RAILS_ROOT /var/www/cat-chat

# Set the rails environment -- in future we can change this
ARG RAILS_ENV=production

# Set working directory in image
WORKDIR $RAILS_ROOT

# Create application home. Server will likely need a pids, so create it in one shot.
RUN mkdir -p $RAILS_ROOT/tmp/pids

# ***If you are vendoring your gems.***
# Create bundle folder. bundle install will installs all gems in image.
RUN mkdir -p $RAILS_ROOT/vendor/bundle

# Use Gemfiles as Docker cache markers. Always bundle before coping app src.
COPY Gemfile Gemfile
COPY Gemfile.log Gemfile.lock

# Public rubygems.
RUN gem source https://rubygems.org/

# Install bundler
RUN gem install bundler

# If you are vendoring your gems.
# Finish establishing ruby env.
COPY vendor/bundle vendor/bundle
RUN bundle install

# Redirect Rails log to STDOUT for Cloud Run to capture
ENV RAILS_LOG_TO_STDOUT=true
# [START cloudrun_rails_dockerfile_key]
ARG MASTER_KEY
ENV RAILS_MASTER_KEY=${MASTER_KEY}

# pre-compile Rails assets with master key
RUN bundle exec rake assets:precompile

# This must be a GCP thing
EXPOSE 8080
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "8080"]
