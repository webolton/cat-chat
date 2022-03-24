#!/usr/bin/env bash

# Set up and run the application
bundle exec rails db:migrate RAILS_ENV="$RAILS_ENV"
RAILS_ENV="$RAILS_ENV" bundle exec puma --daemon --bind unix://tmp/sockets/puma.sock --state tmp/sockets/puma.state --control unix://tmp/sockets/pumactl.sock