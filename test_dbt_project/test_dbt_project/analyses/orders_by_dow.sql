
select
    {% set query %}
        select day_number, day_name from {{ ref('dow') }}
    {% endset %}
    {% set results = run_query(query) %}
    {% if execute %}
        {% for row in results.rows %}
            count(distinct order_id) filter (where order_dow = {{ row[0] }}) as orders_on_{{ row[1] }}_cnt {{ ',' if not loop.last }}
        {% endfor %}
    {% endif %}
from {{ source('raw', 'orders') }}
