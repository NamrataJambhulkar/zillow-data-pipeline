
  
    

create or replace transient table ZILLOW_DATA.CURATED.dim_property
    
    
    
    as (

select distinct
    address,
    home_type,
    area_sqft,
    bedrooms,
    bathrooms,
    zestimate
from ZILLOW_DATA.CURATED.stg_zillow_listings
where address is not null
order by address
    )
;


  