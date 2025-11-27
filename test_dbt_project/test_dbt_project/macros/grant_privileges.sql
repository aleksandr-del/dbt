{% macro grant_privileges(schemaname=target.schema, username=target.user) %}
    {% set query%}
        grant all privileges on all tables in schema {{ schemaname }} to {{ username }};
    {% endset %}

    {{ log('Granting privileges on all tables and views in schema {} to {}'.format(schemaname, username), info=True) }}
    {% do run_query(query) %}
    {{ log('Granted all privileges to {}'.format(username), info=True) }}
{% endmacro %}
