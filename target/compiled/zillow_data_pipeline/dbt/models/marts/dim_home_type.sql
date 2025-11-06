

select distinct
    home_type,
    case
        when home_type ilike '%SINGLE%' then 'Single Family'
        when home_type ilike '%CONDO%' then 'Condominium'
        when home_type ilike '%APARTMENT%' then 'Apartment Unit'
        else 'Other'
    end as category_description
from ZILLOW_DATA.CURATED.stg_zillow_listings
where home_type is not null