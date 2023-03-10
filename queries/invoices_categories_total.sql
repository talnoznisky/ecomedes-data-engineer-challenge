--
-- Get the total amount spent across all invoices broken out by category.
--
-- Output columns:
-- - category_ident::TEXT
-- - total_dollars::INT
--
select
	products.category_ident::text as category_ident
	, sum(items.unit_price_dollars * items.quantity)::int as total_dollars
from invoice_items as items
left join products as products
	on items.product_ident = products.ident
group by 1
order by 1