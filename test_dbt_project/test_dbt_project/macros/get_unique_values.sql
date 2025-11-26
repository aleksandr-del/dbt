{% macro get_unique_values(source_name, source_table, column_name) %}
    {% set query %}
        select distinct "{{ column_name }}" from {{ source(source_name, source_table) }}
    {% endset %}

    {% set result = run_query(query) %}

    {% if result %}
        {% set values = result.columns[0].values() %}
    {% else %}
        {% set values = [] %}
    {% endif %}
    {{ return(values) }}
{% endmacro %}
