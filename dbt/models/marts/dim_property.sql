{{ config(
    materialized='table',
) }}

select distinct
    address,
    home_type,
    area_sqft,
    bedrooms,
    bathrooms,
    zestimate
from {{ ref('stg_zillow_listings') }}
where address is not null
order by address