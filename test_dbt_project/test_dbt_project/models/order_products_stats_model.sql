{{
    config(
        materialized = 'table'
    )
}}

with order_products_stats as (
    select
        tpc.order_hour_of_day,
        oc.order_count,
        sum(oc.order_count) over (partition by 1 order by tpc.order_hour_of_day rows between unbounded preceding and current row) rolling_order_count,
        apc.average_product_count_per_order,
        tpc.total_products_by_hour,
        sum(tpc.total_products_by_hour) over (partition by 1 order by tpc.order_hour_of_day rows between unbounded preceding and current row) rolling_products_count
    from {{ ref('total_product_cnt_model') }} tpc
    left join {{ ref('avg_product_cnt_model') }} apc using(order_hour_of_day)
    left join {{ ref('order_counts_model') }} oc using(order_hour_of_day))

select * from order_products_stats
