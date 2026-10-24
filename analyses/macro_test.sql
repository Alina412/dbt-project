SELECT
{{multiplier('quantity', 'unit_price') }} as price_test
FROM
{{ ref("bronze_sales") }}

