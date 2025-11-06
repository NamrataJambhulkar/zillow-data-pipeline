
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select area_sqft
from ZILLOW_DATA.CURATED.dim_property
where area_sqft is null



  
  
      
    ) dbt_internal_test