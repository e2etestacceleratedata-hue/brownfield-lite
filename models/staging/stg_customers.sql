{{
    config(
        materialized='table'
    )
}}

select
    customer_id,
    trim(name) as customer_name,
    trim(email) as email,
    signup_date

from {{ source('raw', 'customers') }}
