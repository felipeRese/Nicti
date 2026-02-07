-- +goose Up
-- +goose StatementBegin

-- USERS
ALTER TABLE users
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE users
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE users
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON users(deleted_at);


-- SPACES
ALTER TABLE spaces
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE spaces
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE spaces
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_spaces_deleted_at ON spaces(deleted_at);


-- CATEGORIES
ALTER TABLE categories
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE categories
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE categories
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_categories_deleted_at ON categories(deleted_at);


-- SUBCATEGORIES
ALTER TABLE subcategories
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE subcategories
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE subcategories
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_subcategories_deleted_at ON subcategories(deleted_at);


-- PAYMENT_METHODS
ALTER TABLE payment_methods
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE payment_methods
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE payment_methods
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_payment_methods_deleted_at ON payment_methods(deleted_at);


-- GOALS
ALTER TABLE goals
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE goals
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE goals
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_goals_deleted_at ON goals(deleted_at);


-- TRANSACTIONS
ALTER TABLE transactions
  ADD COLUMN created_at TIMESTAMPTZ,
  ADD COLUMN updated_at TIMESTAMPTZ,
  ADD COLUMN deleted_at TIMESTAMPTZ;

UPDATE transactions
SET created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW());

ALTER TABLE transactions
  ALTER COLUMN created_at SET NOT NULL,
  ALTER COLUMN created_at SET DEFAULT NOW(),
  ALTER COLUMN updated_at SET NOT NULL,
  ALTER COLUMN updated_at SET DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_transactions_deleted_at ON transactions(deleted_at);

-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin

-- Drop indexes first (optional but cleaner)
DROP INDEX IF EXISTS idx_transactions_deleted_at;
DROP INDEX IF EXISTS idx_goals_deleted_at;
DROP INDEX IF EXISTS idx_payment_methods_deleted_at;
DROP INDEX IF EXISTS idx_subcategories_deleted_at;
DROP INDEX IF EXISTS idx_categories_deleted_at;
DROP INDEX IF EXISTS idx_spaces_deleted_at;
DROP INDEX IF EXISTS idx_users_deleted_at;

-- Drop columns
ALTER TABLE transactions     DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;
ALTER TABLE goals            DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;
ALTER TABLE payment_methods  DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;
ALTER TABLE subcategories    DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;
ALTER TABLE categories       DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;
ALTER TABLE spaces           DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;
ALTER TABLE users            DROP COLUMN IF EXISTS deleted_at, DROP COLUMN IF EXISTS updated_at, DROP COLUMN IF EXISTS created_at;

-- +goose StatementEnd
