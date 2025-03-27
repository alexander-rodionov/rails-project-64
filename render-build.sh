#!/usr/bin/env bash
# exit on error
set -o errexit

if [[ "$RENDER" == "true" ]]; then
  # Terminate all connections first
  psql $DATABASE_URL -c "SELECT pg_terminate_backend(pg_stat_activity.pid) 
                         FROM pg_stat_activity 
                         WHERE pg_stat_activity.datname = current_database() 
                         AND pid <> pg_backend_pid();"
fi

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

bundle exec rails db:reset

