--
-- Generate a monthly report of the total amount spent in those month's invoices broken out by
-- top level categories. Child categories should be rolled up into their top level category.
--
-- Output columns:
-- - month_year::DATE
-- - category_ident::TEXT
-- - total_price::INT

select
	date_trunc('month', invoices.created_at)::date as month_year 
	, coalesce(categories.parent_ident, products.category_ident)::text as category_ident
	, sum(items.unit_price_dollars * items.quantity)::int as total_price
from invoices 
inner join invoice_items as items
	on invoices.id = items.invoice_id
left join products as products
	on items.product_ident = products.ident
left join categories  as categories
	on products.category_ident = categories.ident
group by 1,2
order by 1

