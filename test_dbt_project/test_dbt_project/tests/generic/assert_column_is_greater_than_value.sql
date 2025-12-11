
{% test assert_column_is_greater_than_value(model, column_name, value) %}

    select
        {{ column_name }}
    from {{ model }}
    where {{ column_name }} <= {{ value }}

{% endtest %}
