# Nicti

## Database migrations (goose)

Install goose:

```bash
go install github.com/pressly/goose/v3/cmd/goose@latest
```

Create and run migrations (sequential numbering):

```bash
make goose-create NAME=init_schema TYPE=sql
make goose-up
```

The Makefile loads connection settings from `.env` via `POSTGRES_*` variables, or you can override with `GOOSE_DBSTRING`, `GOOSE_DRIVER`, or `GOOSE_MIGRATIONS_DIR`.
