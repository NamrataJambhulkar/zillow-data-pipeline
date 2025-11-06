
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select bedrooms
from ZILLOW_DATA.CURATED.dim_property
where bedrooms is null



  
  
      
    ) dbt_internal_test