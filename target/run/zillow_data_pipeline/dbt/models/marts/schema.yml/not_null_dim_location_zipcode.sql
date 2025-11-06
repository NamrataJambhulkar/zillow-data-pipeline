
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select zipcode
from ZILLOW_DATA.CURATED.dim_location
where zipcode is null



  
  
      
    ) dbt_internal_test