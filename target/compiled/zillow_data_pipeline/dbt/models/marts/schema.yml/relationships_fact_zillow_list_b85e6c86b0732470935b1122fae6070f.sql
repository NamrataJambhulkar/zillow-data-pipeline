
    
    

with child as (
    select address as from_field
    from ZILLOW_DATA.CURATED.fact_zillow_listings
    where address is not null
),

parent as (
    select address as to_field
    from ZILLOW_DATA.CURATED.dim_property
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


