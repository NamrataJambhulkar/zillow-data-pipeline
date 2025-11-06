
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select city_name
from ZILLOW_DATA.CURATED.dim_city
where city_name is null



  
  
      
    ) dbt_internal_test