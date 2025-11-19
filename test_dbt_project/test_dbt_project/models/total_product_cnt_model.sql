{{
    config(
        materialized = 'table'
    )
}}

with total_products_cnt as (
    select
        ohd.order_hour_of_day,
        sum(opc.product_count) total_products_by_hour
    from {{ ref('stg_orders_hour_of_day') }} ohd
    left join {{ ref('stg_order_product_counts') }} opc using(order_id)
    group by 1
    order by 1 asc)

select * from total_products_cnt
