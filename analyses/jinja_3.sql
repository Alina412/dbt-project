{% set inc_flg = 1 %}
{% set last_load_date_sk = 3 %}

SELECT 
    *
FROM
    {{ ref("bronze_sales")}}   
 
{% if inc_flg == 1%}    
    where date_sk > {{last_load_date_sk}}
{% endif %}