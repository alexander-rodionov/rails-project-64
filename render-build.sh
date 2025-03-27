#!/usr/bin/env bash
# exit on error
set -o errexit

if [[ "$RENDER" == "true" ]]; then
  DB_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

  # Safely reset the database (with connection handling)
  psql "${DB_URL}" -c "SELECT pg_terminate_backend(pg_stat_activity.pid) 
                        FROM pg_stat_activity 
                        WHERE pg_stat_activity.datname = '${DB_DATABASE}' 
                        AND pid <> pg_backend_pid();" || true

fi

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

bundle exec rails db:reset

