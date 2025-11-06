{{ config(
    materialized='table',
) }}

select distinct
    zipcode,
    city,
    state
from {{ ref('stg_zillow_listings') }}
where zipcode is not null
order by city