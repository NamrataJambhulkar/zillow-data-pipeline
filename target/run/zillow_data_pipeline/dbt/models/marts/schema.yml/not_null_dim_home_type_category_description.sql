
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select category_description
from ZILLOW_DATA.CURATED.dim_home_type
where category_description is null



  
  
      
    ) dbt_internal_test