

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
from ZILLOW_DATA.CURATED.stg_zillow_listings a