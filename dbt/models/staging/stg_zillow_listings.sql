select
    value:address::string as address,
    value:property_city::string as city,
    value:property_state::string as state,
    value:price::float as price,
    value:bedrooms::int as bedrooms,
    value:bathrooms::float as bathrooms,
    value:area_sqft::int as area_sqft,
    value:zestimate::float as zestimate,
    value:zipcode::string as zipcode,
    value:home_type::string as home_type
from {{ source('curated', 'zillow_listings') }}