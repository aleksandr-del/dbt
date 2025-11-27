{% docs instacart_tables %}

A publicly available, anonymized collection from Instacart (a U.S. online grocery delivery service). Released in 2017 via Kaggle, it includes over 3 million grocery orders from more than 200,000 users, spanning 4-100 orders per user.

{% enddocs %}

{% docs department_stats_mart %}

Pivoted view of product counts by department and hour of day.
Each department becomes a column with aggregated product counts.
Dynamically generates columns based on distinct departments in the source data.

Note: Department columns are created at compile time and will update
when new departments are added to the source data (requires recompilation).

{% enddocs%}

{% docs grant_privileges %}

A macro that grants all privileges on all tables and views in a schema to a user

{% enddocs %}
