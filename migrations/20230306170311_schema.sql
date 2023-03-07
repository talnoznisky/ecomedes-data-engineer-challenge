CREATE TYPE subscription AS ENUM (
  'free'
, 'basic'
, 'premium'
);

CREATE TABLE users (
  id INT8 PRIMARY KEY NOT NULL
, name TEXT NOT NULL
);

CREATE TABLE accounts (
  id INT8 PRIMARY KEY NOT NULL
, name TEXT NOT NULL
, subscription subscription NOT NULL
);

CREATE TABLE categories (
  ident TEXT PRIMARY KEY NOT NULL
, name TEXT NOT NULL
, parent_ident TEXT
, CONSTRAINT categories__parent_ident__categories__ident
    FOREIGN KEY (parent_ident)
    REFERENCES categories (ident)
);

CREATE TABLE products (
  ident TEXT PRIMARY KEY NOT NULL
, name TEXT NOT NULL
, category_ident TEXT NOT NULL
, CONSTRAINT products__category_ident__categories__ident
    FOREIGN KEY (category_ident)
    REFERENCES categories (ident)
);

CREATE TABLE invoices (
  id INT8 PRIMARY KEY NOT NULL
, name TEXT NOT NULL
, created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE invoice_items (
  id INT8 PRIMARY KEY NOT NULL
, invoice_id INT8 NOT NULL
, product_ident TEXT NOT NULL
, quantity INT4 NOT NULL
, unit_price_dollars INT4 NOT NULL
, CONSTRAINT invoice_items__invoice_id__invoices__id
    FOREIGN KEY (invoice_id)
    REFERENCES invoices (id)
, CONSTRAINT invoice_items__product_ident__products__ident
    FOREIGN KEY (product_ident)
    REFERENCES products (ident)
);

CREATE TABLE user_accounts (
  user_id INT8 NOT NULL
, account_id INT8 NOT NULL
, CONSTRAINT user_accounts__user_id__invoices__id
  FOREIGN KEY (user_id)
  REFERENCES users (id)
, CONSTRAINT user_accounts__account_id__accounts__id
  FOREIGN KEY (account_id)
  REFERENCES accounts (id)
);

CREATE TABLE user_auth (
  user_id INT8 NOT NULL
, invoice_id INT8 NOT NULL
, CONSTRAINT user_auth__user_id__invoices__id
  FOREIGN KEY (user_id)
  REFERENCES users (id)
, CONSTRAINT user_auth__invoice_id__invoices__id
  FOREIGN KEY (invoice_id)
  REFERENCES invoices (id)
);

CREATE TABLE account_auth (
  account_id INT8 NOT NULL
, invoice_id INT8 NOT NULL
, CONSTRAINT account_auth__account_id__invoices__id
  FOREIGN KEY (account_id)
  REFERENCES accounts (id)
, CONSTRAINT account_auth__invoice_id__invoices__id
  FOREIGN KEY (invoice_id)
  REFERENCES invoices (id)
);
