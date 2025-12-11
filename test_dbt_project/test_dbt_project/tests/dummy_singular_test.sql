
{% set query %}
    select
        min(order_count) min_order_count,
        max(order_count) max_order_count
    from {{ ref('order_counts_model') }}
{% endset %}
{% if execute %}
    {% set result = dbt_utils.get_query_results_as_dict(query) %}
    {% set min_order_count = result['min_order_count'][0] %}
    {% set max_order_count = result['max_order_count'][0] %}
{% endif %}

select
    order_hour_of_day, order_count
from {{ ref('order_counts_model') }}
where
    order_count <= {{ min_order_count }}
    or order_count >= {{ max_order_count }}
