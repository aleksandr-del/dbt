{% macro union_all(table='stg_order_department_hour_of_day') %}
    {% set query %}
        select distinct department from {{ source('raw', 'departments') }}
    {% endset %}

    {% if execute %}
        {% set departments = run_query(query).columns[0].values() %}
    {% else %}
        {% set departments = [] %}
    {% endif %}

    {% if departments %}
        {% for dep in departments %}
            {% if not loop.first %}
                union all
            {% endif %}
            select
                t.department, count(distinct t.order_id) total_orders_cnt
            from {{ ref(table) }} t
            where t.department = '{{ dep }}'
            group by t.department
        {% endfor %}
    {% endif %}
{% endmacro %}
