
    
    

select
    home_type as unique_field,
    count(*) as n_records

from ZILLOW_DATA.CURATED.dim_home_type
where home_type is not null
group by home_type
having count(*) > 1


