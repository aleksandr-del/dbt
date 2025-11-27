
select
    *
from {{ ref('orders_by_department_stats_model') }}
where total_orders_cnt < 0
