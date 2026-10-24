with returns as (
    select 
        store_sk,
        product_sk,
        returned_qty,
        return_reason,
        refund_amount
    from 
    {{ ref('bronze_returns')}}    

),
product as (
    select 
        product_sk,
        product_name,
        category
    from
        {{ ref("bronze_product")}}

),
store as (
    SELECT
        store_sk,
        city,
        region,
        country
    FROM
    {{ ref("bronze_store")}}

),

joined_data as(
SELECT s.city,
    s.country,
    p.product_name,
    p.category,
    r.returned_qty,
    r.refund_amount,
    r.return_reason
FROM returns r
join product p USING (product_sk)
join store s USING (store_sk) 
)


select category,
    return_reason,
    round(SUM(refund_amount), 2) AS total_refunds
from joined_data
group by category,
    return_reason
order by category,total_refunds desc