
    
    

select
    address as unique_field,
    count(*) as n_records

from ZILLOW_DATA.CURATED.dim_property
where address is not null
group by address
having count(*) > 1


