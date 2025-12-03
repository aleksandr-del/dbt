
{{
    config(
        materialized='incremental',
        incremental_strategy='append',
        on_schema_change='fail'
    )
}}

select
    o.order_id,
    o.user_id,
    o.order_number
from {{ source('raw', 'orders') }} o
where
    1 = 1
{% if not is_incremental() %}
    and o.order_number = 1
{% endif %}
{% if is_incremental() %}
    and o.order_number = (select max(order_number) + 1 from {{ this }} )
{% endif %}
