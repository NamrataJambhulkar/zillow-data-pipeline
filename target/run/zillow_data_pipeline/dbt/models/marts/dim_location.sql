
  
    

create or replace transient table ZILLOW_DATA.CURATED.dim_location
    
    
    
    as (

select distinct
    zipcode,
    city,
    state
from ZILLOW_DATA.CURATED.stg_zillow_listings
where zipcode is not null
order by city
    )
;


  