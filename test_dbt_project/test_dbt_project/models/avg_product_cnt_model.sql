{{
    config(
        materialized = 'view'
    )
}}

with average_product_count_per_order as (
    select
        ohd.order_hour_of_day,
        round(avg(opc.product_count), 3) average_product_count_per_order
    from {{ ref('stg_orders_hour_of_day') }} ohd
    left join {{ ref('stg_order_product_counts') }} opc using(order_id)
    group by 1
    order by 1 asc)

select * from average_product_count_per_order
