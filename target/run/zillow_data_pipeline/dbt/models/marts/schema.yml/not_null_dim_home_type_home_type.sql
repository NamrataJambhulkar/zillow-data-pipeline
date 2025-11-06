
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select home_type
from ZILLOW_DATA.CURATED.dim_home_type
where home_type is null



  
  
      
    ) dbt_internal_test