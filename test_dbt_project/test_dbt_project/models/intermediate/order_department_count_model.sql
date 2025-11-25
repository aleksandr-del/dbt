with order_department_count as (
    select
        order_id,
        order_hour_of_day,
        department,
        count(*) product_cnt
    from {{ ref('stg_order_department_hour_of_day') }}
    group by 1, 2, 3)

select * from order_department_count
