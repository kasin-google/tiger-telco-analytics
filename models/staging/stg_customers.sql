select
    id as customer_id,
    first_name,
    last_name,
    last_modified

from {{ source('jaffle_shop', 'jaffle_shop_customers') }}