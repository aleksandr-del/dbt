
with raw_total_orders_cnt as (
	select
		count(order_id) raw_total_orders_cnt
	from {{ source('raw', 'orders') }}),

mart_total_orders_cnt as (
	select
		sum(order_count) mart_total_orders_cnt
	from {{ ref('order_products_stats_model') }})

select
	mart_total_orders_cnt,
	raw_total_orders_cnt,
	mart_total_orders_cnt - raw_total_orders_cnt difference
from mart_total_orders_cnt mtoc
cross join raw_total_orders_cnt rtoc
where
    mart_total_orders_cnt <> raw_total_orders_cnt
