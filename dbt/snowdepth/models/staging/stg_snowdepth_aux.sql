{{ config(materialized='view') }}
-- stg_snowdepth_aux

with source as (

    select
        *
    from {{ source('snowdepth', 'V_snowdepth_intensive_aux') }}

),
stg_snowdepth_aux as (

    select
        sn_region,
        sn_locality,
        sn_section,
        sc_type_of_sites_ecological,
        sn_site,
        sn_site_old,
        year_first::int,
        case
            when year_last = 'NA' then null
            else year_last::int
        end                                     as year_last
    from source
    where 1 is not null
    
)
select * from stg_snowdepth_aux