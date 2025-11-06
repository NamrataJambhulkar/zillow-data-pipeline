{{ config( 
    materialized='table'
) }}

select distinct
    city as city_name,
    state,
from {{ ref('stg_zillow_listings') }}
where city is not null
order by city_name