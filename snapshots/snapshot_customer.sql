{% snapshot snapshot_customers %}

{{
    config(
      target_database='caramel-brook-342204',
      target_schema='dbt_dataset_snapshot',
      unique_key='customer_id',

      strategy='timestamp',
      updated_at='last_modified',
    )
}}

select * from {{ ref('full_customers') }}

{% endsnapshot %}
