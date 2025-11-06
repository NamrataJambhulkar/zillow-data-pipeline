
    
    

with child as (
    select home_type as from_field
    from ZILLOW_DATA.CURATED.dim_property
    where home_type is not null
),

parent as (
    select home_type as to_field
    from ZILLOW_DATA.CURATED.dim_home_type
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


