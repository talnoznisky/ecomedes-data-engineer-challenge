--
-- Get all users with all their invoices.
--
-- Output columns:
-- - user_id::INT
-- - user_name::TEXT
-- - invoice_id::INT
-- - invoice_name::TEXT
--

select 
	users.id::int as user_name
	, users."name"::text as user_name 
	, invoices.id::int as invoice_id
	, invoices.name::text as invoice_name
from user_auth
left join users on user_auth.user_id = users.id
left join invoices on user_auth.invoice_id = invoices.id
