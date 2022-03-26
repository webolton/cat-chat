#!/usr/bin/env bash

# Set up and run the database
set -e
echo "local    all             all             trust" > /etc/postgresql/*/main/pg_hba.conf
/etc/init.d/postgresql start

# Set up and run the application
bundle exec rails db:create RAILS_ENV="$RAILS_ENV"
bundle exec rails db:migrate RAILS_ENV="$RAILS_ENV"

# If we were using NGINX
# RAILS_ENV="$RAILS_ENV" bundle exec puma --bind unix://tmp/sockets/puma.sock \
#   --state tmp/sockets/puma.state

# Binding puma to TCP
RAILS_ENV="$RAILS_ENV" bundle exec puma --bind tcp://0.0.0.0:3000 \
  --state tmp/sockets/puma.state
