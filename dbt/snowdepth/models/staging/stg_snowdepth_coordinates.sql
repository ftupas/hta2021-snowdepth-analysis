{{ config(materialized='view') }}
-- stg_snowdepth_coordinates

with source as (

    select
        *
    from {{ source('snowdepth', 'V_snowdepth_intensive_coordinates') }}

),
stg_snowdepth_coordinates as (

    select
        sn_site,
        e_dd::decimal    as lon,
        n_dd::decimal    as lat,
        e_utm33::decimal,
        n_utm33::decimal
    from source
    where 1 is not null

)
select * from stg_snowdepth_coordinates