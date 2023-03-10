--
-- Get all invoices for Acme Corp
--
-- Output columns:
-- - invoice_id::INT
-- - invoice_name::TEXT
--
select
	account_auth.invoice_id::int as invoice_id
	, invoices.name::text as invoice_name
from account_auth 
left join invoices
	on account_auth.invoice_id = invoices.id
where account_auth.account_id = (
	select account_id::int from accounts where name = 'Acme Corp'
)
