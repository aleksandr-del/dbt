{{
    config(
        materialized ='view'
    )
}}


with order_product_counts as (
	select
		order_id,
		count(distinct product_id) product_count
	from {{ source('raw', 'order_products') }}
	group by 1)

select * from order_product_counts
