{{ config(materialized='table') }}
-- dim_snowdepth_aux

with source as (

    select
        *
    from {{ ref('stg_snowdepth_aux') }}

),
dim_snowdepth_coordinates as (

    select
        id,
        sn_site
    from {{ ref('dim_snowdepth_coordinates') }}

),
dim_snowdepth_aux as (

    select
        row_number() over
            (order by source.sn_site)       as id,
        coordinates.id                      as coordinate_id,
        sc_type_of_sites_ecological,
        sn_site_old,
        year_first,
        year_last
    from source
    left join dim_snowdepth_coordinates coordinates
        on source.sn_site = coordinates.sn_site
    
)
select * from dim_snowdepth_aux