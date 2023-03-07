--
-- Generate a monthly report of the total amount spent in those month's invoices broken out by
-- top level categories. Child categories should be rolled up into their top level category.
--
-- Output columns:
-- - month_year::DATE
-- - category_ident::TEXT
-- - total_price::INT
--

-- Write your query here:

SELECT NULL::DATE AS month_year
     , NULL::TEXT AS category_ident
     , NULL::INT AS total_price
 WHERE FALSE
