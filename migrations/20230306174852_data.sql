INSERT INTO users (id, name)
VALUES
  (101, 'Alice')
, (102, 'Bob')
, (103, 'Charlie')
, (104, 'Daisy')
, (105, 'Ethan')
, (106, 'Fiona')
, (107, 'Grace')
;

INSERT INTO accounts (id, name, subscription)
VALUES
  (201, 'Acme Corp', 'free')
, (202, 'Widget Co', 'basic')
, (203, 'Gadget Inc', 'premium')
, (204, 'Financial Solutions Inc', 'premium')
;

INSERT INTO categories (ident, name, parent_ident)
VALUES
  ('electronics', 'Electronics', NULL)
, ('phones', 'Phones', 'electronics')
, ('computers', 'Computers', 'electronics')
, ('laptops', 'Laptops', 'computers')
, ('tablets', 'Tablets', 'computers')
, ('accessories', 'Accessories', 'electronics')
, ('plumbing', 'Plumbing', NULL)
, ('toilets', 'Toilets', 'plumbing')
, ('flush-valves', 'Flush Valves', 'plumbing')
;

INSERT INTO products (ident, name, category_ident)
VALUES
  ('iphone-xr', 'iPhone XR', 'phones')
, ('macbook-air', 'MacBook Air', 'laptops')
, ('ipad-pro', 'iPad Pro', 'tablets')
, ('airpods', 'AirPods', 'accessories')
, ('plunger', 'Plunger', 'plumbing')
, ('kohler-toilet', 'Kohler Toilet', 'toilets')
, ('everbilt-fv', 'Everbilt Flush Valve', 'flush-valves')
, ('as-fv', 'American Standard Flush Valve', 'flush-valves')
;

INSERT INTO invoices (id, name, created_at)
VALUES
  (301, 'Invoice 1', '2000-03-01 00:00:00')
, (302, 'Invoice 2', '2000-03-31 00:00:00')
, (303, 'Invoice 3', '2000-04-01 00:00:00')
, (304, 'Invoice 4', '2000-04-05 00:00:00')
, (305, 'Invoice 5', '2000-04-15 00:00:00')
, (306, 'Invoice 6', '2000-04-30 00:00:00')
, (307, 'Invoice 7', '2000-05-01 00:00:00')
, (308, 'Invoice 8', '2000-05-31 00:00:00')
;

INSERT INTO invoice_items (id, invoice_id, product_ident, quantity, unit_price_dollars)
VALUES
  (401, 301, 'iphone-xr', 4, 10)
, (402, 301, 'macbook-air', 1, 100)
, (403, 301, 'ipad-pro', 3, 20)
, (404, 302, 'airpods', 10, 2)
, (405, 302, 'kohler-toilet', 2, 10)
, (406, 302, 'macbook-air', 1, 50)
, (407, 303, 'kohler-toilet', 4, 3)
, (408, 303, 'airpods', 5, 5)
, (409, 303, 'as-fv', 1, 1)
, (410, 304, 'iphone-xr', 32, 2)
, (411, 304, 'plunger', 7, 12)
, (412, 304, 'everbilt-fv', 7, 10)
, (413, 305, 'as-fv', 5, 20)
, (414, 305, 'ipad-pro', 2, 100)
, (415, 305, 'ipad-pro', 2, 110)
, (416, 306, 'macbook-air', 4, 10)
, (417, 306, 'ipad-pro', 6, 6)
, (418, 306, 'plunger', 6, 10)
, (419, 307, 'macbook-air', 33, 3)
, (420, 307, 'kohler-toilet', 12, 2)
, (421, 307, 'ipad-pro', 2, 6)
;

INSERT INTO user_accounts (user_id, account_id)
VALUES
  (101, 201)
, (102, 201)
, (102, 202)
, (102, 203)
, (103, 204)
;

INSERT INTO user_auth (user_id, invoice_id)
VALUES
  (101, 302)
, (101, 305)
, (104, 306)
, (105, 307)
, (106, 307)
;

INSERT INTO account_auth (account_id, invoice_id)
VALUES
  (201, 301)
, (201, 302)
, (202, 303)
, (203, 304)
;
