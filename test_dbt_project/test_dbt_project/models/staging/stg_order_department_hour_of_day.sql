
with order_department_hour_of_day as(
    select
        o.order_id,
        o.order_hour_of_day,
        d.department
    from raw.orders o
    join {{ source('raw', 'order_products') }} op on op.order_id = o.order_id
    join {{ source('raw', 'products') }} p on p.product_id = op.product_id
    join {{ source('raw', 'departments') }} d on d.department_id = p.department_id)

select * from order_department_hour_of_day
