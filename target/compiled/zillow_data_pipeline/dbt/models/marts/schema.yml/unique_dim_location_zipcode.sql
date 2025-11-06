
    
    

select
    zipcode as unique_field,
    count(*) as n_records

from ZILLOW_DATA.CURATED.dim_location
where zipcode is not null
group by zipcode
having count(*) > 1


