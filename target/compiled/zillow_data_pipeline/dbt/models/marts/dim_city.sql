

select distinct
    city as city_name,
    state,
from ZILLOW_DATA.CURATED.stg_zillow_listings
where city is not null
order by city_name