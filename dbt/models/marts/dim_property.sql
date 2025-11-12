with ranked as (
    select
        address,
        coalesce(bedrooms, 0) as bedrooms,
        coalesce(bathrooms, 0) as bathrooms,
        coalesce(area_sqft, 0) as area_sqft,
        city,
        state,
        zipcode,
        home_type,
        price,
        zestimate,
        row_number() over (partition by address order by price desc) as rn
    from {{ ref('stg_zillow_listings') }}
    where address is not null
)
select *
from ranked
where rn = 1