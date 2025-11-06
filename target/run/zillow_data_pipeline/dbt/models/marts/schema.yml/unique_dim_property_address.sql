
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    address as unique_field,
    count(*) as n_records

from ZILLOW_DATA.CURATED.dim_property
where address is not null
group by address
having count(*) > 1



  
  
      
    ) dbt_internal_test