#!/usr/bin/env bash
set -o errexit

DB_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

echo "Doing database users reset"

psql "${DB_URL}" -c "
  DO \$\$ DECLARE
      r RECORD;
  BEGIN
      FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = current_schema()) LOOP
          EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
      END LOOP;
  END \$\$;
"

bundle exec rails db:migrate
bundle exec rails db:seed

