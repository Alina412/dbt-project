with deduplicated as (
    select 
    *,
    row_number() over(partition by id order by update_dttm desc) as deduplication_id
from 
 {{ source('source', 'items') }}
)

select 
id,
name,
category,
update_dttm
from deduplicated
where 
deduplication_id = 1