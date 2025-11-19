{{
    config(
        materialized = 'table'
    )
}}

with order_counts as (
	select
		order_hour_of_day,
		count(*) order_count
	from {{ ref('stg_orders_hour_of_day') }}
	group by order_hour_of_day
	order by order_hour_of_day asc)

select * from order_counts
