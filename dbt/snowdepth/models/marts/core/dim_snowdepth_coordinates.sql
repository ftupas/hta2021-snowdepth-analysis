{{ config(materialized='table') }}
-- dim_snowdepth_coordinates

with source as (

    select
        *
    from {{ ref('stg_snowdepth_coordinates') }}

),
sites as (

    select distinct
        sn_region,
        sn_locality,
        sn_section,
        sn_site
    from {{ ref('stg_snowdepth_aux') }}

),
dim_snowdepth_coordinates as (

    select
        row_number() over
            (order by source.sn_site)   as id,
        sn_region,
        sn_locality,
        sn_section,
        source.sn_site,
        lon,
        lat,
        e_utm33,
        n_utm33
    from source
    left join sites using (sn_site)
    
)
select * from dim_snowdepth_coordinates