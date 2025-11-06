
    
    

select
    city_name as unique_field,
    count(*) as n_records

from ZILLOW_DATA.CURATED.dim_city
where city_name is not null
group by city_name
having count(*) > 1


