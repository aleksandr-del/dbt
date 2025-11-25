with department_stats as (
    select
        order_hour_of_day,
        {%- set query -%}
            select distinct department from {{ source('raw', 'departments') }}
        {%- endset -%}
        {%- set result = run_query(query) -%}
        {%- if result -%}
            {%- set departments = result.columns[0].values() -%}
        {%- else -%}
            {%- set departments = [] -%}
        {%- endif -%}
        {% for department in departments %}
            sum(case when department = '{{ department }}' then product_cnt else 0 end) as "{{ department }}"
            {%- if not loop.last %},{% endif %}
        {% endfor %}
    from {{ ref('order_department_count_model') }}
    group by 1)

select * from department_stats
