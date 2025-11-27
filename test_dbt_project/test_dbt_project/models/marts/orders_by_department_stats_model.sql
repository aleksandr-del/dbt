-- depends_on: {{ ref('stg_order_department_hour_of_day') }}
{{
    config(
        materialized='table'
    )
}}

select * from (
    {{ union_all() }}
) as combined
