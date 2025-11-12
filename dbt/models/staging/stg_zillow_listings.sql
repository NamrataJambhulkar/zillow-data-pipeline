select
    distinct
    value:address::string as address,
    value:property_city::string as city,
    value:property_state::string as state,
    value:price::float as price,
    coalesce(value:bedrooms::int, 0) as bedrooms,
    coalesce(value:bathrooms::float, 0) as bathrooms,
    coalesce(value:area_sqft::int, 0) as area_sqft,
    value:zestimate::float as zestimate,
    value:zipcode::string as zipcode,
    value:home_type::string as home_type
from {{ source('curated', 'zillow_listings') }}
where value:address::string is not null