{%- set databases = ["PostgreSQL", "MSSQL", "MySQL", "Clickhouse", "SQLLite", "MariaDB", "MongoDB"] -%}

{% for i in databases %}
    {% if i !=  "SQLLite"  %}
        {{ i }}
        
    {% endif %}
{% endfor %}