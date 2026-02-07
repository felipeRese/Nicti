#!/usr/bin/env bash
set -euo pipefail

: "${POSTGRES_DB:=nicti}"
: "${POSTGRES_USER:=nicti}"
: "${POSTGRES_PASSWORD:=nicti_dev_password}"
: "${POSTGRES_HOST:=localhost}"
: "${POSTGRES_PORT:=5432}"

goose_driver="${GOOSE_DRIVER:-postgres}"
migrations_dir="${GOOSE_MIGRATIONS_DIR:-migrations}"

if [[ -n "${GOOSE_DBSTRING:-}" ]]; then
  dbstring="$GOOSE_DBSTRING"
else
  dbstring="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable"
fi

exec goose -dir "$migrations_dir" "$goose_driver" "$dbstring" "$@"
