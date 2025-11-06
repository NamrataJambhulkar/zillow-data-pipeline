{{ config(
    materialized='table'
) }}

select
    a.address,
    a.city,
    a.state,
    a.zipcode,
    a.home_type,
    a.bedrooms,
    a.bathrooms,
    a.area_sqft,
    a.price,
    a.zestimate,
    current_timestamp() as load_time
from {{ ref('stg_zillow_listings') }} a