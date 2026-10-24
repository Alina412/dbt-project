{% set inc_flg = 1 %}
{% set last_load_date_sk = 3 %}


{% set col_list = ["sales_id", "date_sk", "gross_amount"] %}

SELECT 
    {% for i in col_list %}
        {{i}}{% if not loop.last %}, {% endif%}
    {% endfor %}
FROM
    {{ ref("bronze_sales")}}   
 
{% if inc_flg == 1%}    
    where date_sk > {{last_load_date_sk}}
{% endif %}