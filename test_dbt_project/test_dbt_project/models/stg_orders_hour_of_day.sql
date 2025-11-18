{{
    config(
        materialized = 'view'
    )
}}


with orders_hour_of_day as (
    select
		order_id,
		order_hour_of_day
	from raw.orders)

select * from orders_hour_of_day
