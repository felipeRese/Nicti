ENV_FILE := .env
-include $(ENV_FILE)

export POSTGRES_DB POSTGRES_USER POSTGRES_PASSWORD POSTGRES_PORT POSTGRES_HOST
export GOOSE_DBSTRING GOOSE_DRIVER GOOSE_MIGRATIONS_DIR

GOOSE := ./scripts/goose.sh
TYPE ?= sql
GOOSE_CREATE_FLAGS ?= -s

.PHONY: goose-up goose-down goose-status goose-create goose-redo goose-reset goose-version

goose-up:
	$(GOOSE) up

goose-down:
	$(GOOSE) down

goose-status:
	$(GOOSE) status

goose-redo:
	$(GOOSE) redo

goose-reset:
	$(GOOSE) reset

goose-version:
	$(GOOSE) version

goose-create:
	@if [ -z "$(NAME)" ]; then echo "NAME is required. Usage: make goose-create NAME=init_schema TYPE=sql"; exit 1; fi
	$(GOOSE) create $(GOOSE_CREATE_FLAGS) "$(NAME)" "$(TYPE)"
