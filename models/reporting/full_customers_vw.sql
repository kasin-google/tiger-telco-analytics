{{
    config(
        materialized='view'
    )
}}

SELECT * except (dbt_valid_from, dbt_valid_to), CASE
          WHEN dbt_valid_from = MIN(dbt_valid_from) OVER(PARTITION BY customer_id) THEN '1901-01-01'
          ELSE      
            dbt_valid_from
          END as dbt_valid_from,
          dbt_valid_to
from {{ ref('snapshot_customers') }}
