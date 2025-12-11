{% set temperature = 65.0 %}

On a day like this, I especially like
{% if temperature >= 75.0 %}
    a refreshing lemon sorbet
{% else %}
    a decadent chocolate cake
{% endif %}

{% set my_string = 'my variable string!' %}
{% set my_number = 26.0 %}
{% set my_list = ['apple', 'banana', 'orange'] %}
{% for fruit in my_list %}
    {{ fruit }}
{% endfor %}
{% set my_dict = {'name': 'Alexander', 'age': 44} %}
{{ my_string }} {{ my_number }} {{ my_list[0] }} {{ my_dict['name'] }}

{#
{% set length = 20 %}

{% for j in range(length) %}
    select {{ j }} as number {% if not loop.last %} union all {% endif %}
{% endfor %}
#}

{#
This is a comment!
#}

{% set foods = ['redish', 'cucumber', 'chicken nugget', 'avacado'] %}

{% for food in foods %}
    {%- if food == 'chicken nugget' -%}
        {%- set food_type = 'snack' -%}
    {%- else -%}
        {%- set food_type = 'vegetable' -%}
    {%- endif -%}
    My delicious {{ food }} is my favorite {{ food_type }}
{% endfor %}

{% set departments = get_unique_values('raw', 'departments', 'department') %}
{{ departments }}

{% set values = dbt_utils.get_column_values(table=source('raw', 'departments'), column='department') %}
Values: {{ values }}


{{ codegen.generate_model_yaml(model_names=['department_stats_model']) }}

{{ dbt_utils.date_spine(datepart="day", start_date="cast('2025-11-01' as date)", end_date="cast('2025-11-30' as date)") }}

{{ target.user }} {{ target.schema }}

{#
{{ scratch_macro() }}
#}

{% set relations =  dbt_utils.get_relations_by_prefix(schema=target.schema, prefix='stg_') %}
{% for table in relations %}
    {{ table.identifier }}
{% endfor %}

{% set var = env_var('DBT_WORKDIR', target.schema) %}
{{ var }}

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
{{ min_order_count, max_order_count }}
