-- +goose Up
-- +goose StatementBegin

CREATE TABLE users (
  id        BIGSERIAL PRIMARY KEY,
  email     TEXT NOT NULL UNIQUE,
  name      TEXT NOT NULL
);

CREATE TABLE spaces (
  id        BIGSERIAL PRIMARY KEY,
  user_id   BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  nickname  TEXT NOT NULL,
  balance   NUMERIC(14,2) NOT NULL DEFAULT 0
);

CREATE TABLE categories (
  id        BIGSERIAL PRIMARY KEY,
  space_id  BIGINT NOT NULL REFERENCES spaces(id) ON DELETE CASCADE,
  type      TEXT NOT NULL,
  name      TEXT NOT NULL,
  CONSTRAINT categories_type_chk CHECK (type IN ('income', 'expense')),
  CONSTRAINT categories_space_name_uniq UNIQUE (space_id, name)
);

CREATE TABLE subcategories (
  id          BIGSERIAL PRIMARY KEY,
  space_id    BIGINT NOT NULL REFERENCES spaces(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  CONSTRAINT subcategories_cat_name_uniq UNIQUE (category_id, name)
);

CREATE TABLE payment_methods (
  id        BIGSERIAL PRIMARY KEY,
  space_id  BIGINT NOT NULL REFERENCES spaces(id) ON DELETE CASCADE,
  name      TEXT NOT NULL,
  CONSTRAINT payment_methods_space_name_uniq UNIQUE (space_id, name)
);

CREATE TABLE goals (
  id        BIGSERIAL PRIMARY KEY,
  space_id  BIGINT NOT NULL REFERENCES spaces(id) ON DELETE CASCADE,
  name      TEXT NOT NULL,
  amount    NUMERIC(14,2) NOT NULL DEFAULT 0,
  CONSTRAINT goals_space_name_uniq UNIQUE (space_id, name)
);

CREATE TABLE transactions (
  id             BIGSERIAL PRIMARY KEY,
  name           TEXT NOT NULL,
  type           TEXT NOT NULL,
  category_id    BIGINT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  subcategory_id BIGINT REFERENCES subcategories(id) ON DELETE SET NULL,
  method_id      BIGINT NOT NULL REFERENCES payment_methods(id) ON DELETE RESTRICT,
  value          NUMERIC(14,2) NOT NULL,
  space_id       BIGINT NOT NULL REFERENCES spaces(id) ON DELETE CASCADE,
  CONSTRAINT transactions_type_chk CHECK (type IN ('income', 'expense'))
);

-- Helpful indexes for FKs / common filters
CREATE INDEX idx_spaces_user_id               ON spaces(user_id);
CREATE INDEX idx_categories_space_id          ON categories(space_id);
CREATE INDEX idx_subcategories_space_id       ON subcategories(space_id);
CREATE INDEX idx_subcategories_category_id    ON subcategories(category_id);
CREATE INDEX idx_payment_methods_space_id     ON payment_methods(space_id);
CREATE INDEX idx_goals_space_id               ON goals(space_id);
CREATE INDEX idx_transactions_space_id        ON transactions(space_id);
CREATE INDEX idx_transactions_category_id     ON transactions(category_id);
CREATE INDEX idx_transactions_subcategory_id  ON transactions(subcategory_id);
CREATE INDEX idx_transactions_method_id       ON transactions(method_id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS goals;
DROP TABLE IF EXISTS payment_methods;
DROP TABLE IF EXISTS subcategories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS spaces;
DROP TABLE IF EXISTS users;

-- +goose StatementEnd
