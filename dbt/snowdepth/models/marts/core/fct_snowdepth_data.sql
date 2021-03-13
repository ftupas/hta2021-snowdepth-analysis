{{ config(materialized='table') }}
-- dim_snowdepth_data

with source as (

    select
        *
    from {{ ref('stg_snowdepth_data') }}

),
dim_snowdepth_coordinates as (

    select
        id,
        sn_site
    from {{ ref('dim_snowdepth_coordinates') }}

),
fct_snowdepth_data as (

    select
        row_number() over 
            (order by t_date asc)       as id,
        coordinates.id                  as coordinate_id,
        sn_plot,
        t_date,
        v_observer,
        v_depth,
        year
    from source 
    left join dim_snowdepth_coordinates coordinates
        on source.sn_site = coordinates.sn_site
    
)
select * from fct_snowdepth_data