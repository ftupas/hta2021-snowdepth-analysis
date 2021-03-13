{{ config(materialized='view') }}
-- stg_snowdepth_data

with source as (

    select
        *
    from {{ source('snowdepth', 'V_snowdepth_intensive_data') }}

),
stg_snowdepth_data as (

    select
        sn_region,
        sn_locality,
        sn_section,
        sn_site,
        sn_plot::int,
        t_date::date,
        v_observer,
        v_depth::int,
        extract(YEAR from t_date::date) as year
    from source
    where 1 is not null

)
select * from stg_snowdepth_data