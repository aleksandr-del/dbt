
with mart_total_products_cnt as (
	select
		sum(total_products_by_hour) mart_total_products_cnt
	from {{ ref('order_products_stats_model') }}),

raw_total_products_cnt as (
	select
		count(*) raw_total_products_cnt
	from {{ source('raw', 'order_products') }})

select
	mart_total_products_cnt,
	raw_total_products_cnt,
	mart_total_products_cnt - raw_total_products_cnt difference
from mart_total_products_cnt
cross join raw_total_products_cnt
where mart_total_products_cnt <> raw_total_products_cnt
