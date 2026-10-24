with sales as (
    select 
        sales_id,
        customer_sk,
        product_sk,
        quantity,
        unit_price,
        gross_amount,
        {{ multiplier('quantity', 'unit_price') }} as total_amount
    from 
    {{ ref('bronze_sales')}}    

),
product as (
    select 
        product_sk,
        product_name,
        category
    from
        {{ ref("bronze_product")}}

),
customer as (
    SELECT
        customer_sk,
        first_name ||  ' ' ||  last_name as name,
        gender,
        loyalty_tier
    FROM
    {{ ref("bronze_customer")}}

),
{# validated_sales as (
    select * from sales
    where total_amount = gross_amount
) #}

joined_data as(
SELECT c.name,
    c.gender,
    c.loyalty_tier,
    p.product_name,
    p.category,
    s.quantity,
    round(s.total_amount, 2) as total_amount,
    gross_amount
FROM sales s
join product p USING (product_sk)
join customer c USING (customer_sk) 
)

select category,
    gender,
    round(SUM(gross_amount), 2) AS total_sales
from joined_data
group by category,
    gender
order by total_sales desc