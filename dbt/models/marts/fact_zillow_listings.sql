{{ config(
    materialized='table'
) }}

with property as (
    select * from {{ ref('dim_property') }}
),
location as (
    select * from {{ ref('dim_location') }}
),
city as (
    select * from {{ ref('dim_city') }}
),
home_type as (
    select * from {{ ref('dim_home_type') }}
)

select
    p.address,
    l.zipcode,
    c.city_name as city,
    c.state,
    h.home_type,
    h.category_description as home_type_category,
    p.area_sqft,
    p.bedrooms,
    p.bathrooms,
    p.zestimate
from property p
left join location l on p.address like concat('%', l.zipcode, '%')
left join city c on l.city = c.city_name
left join home_type h on p.home_type = h.home_type
