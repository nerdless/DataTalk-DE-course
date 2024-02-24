{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *, 
        'Green' as service_type
    from {{ ref('stg_fhv_tripdata') }}
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    fhv_tripdata.tripid,
    fhv_tripdata.dispatching_base_num,
    fhv_tripdata.Affiliated_base_number,
    fhv_tripdata.PUlocationID,
    fhv_tripdata.DOlocationID,
    fhv_tripdata.pickup_datetime,
    fhv_tripdata.dropOff_datetime,
    fhv_tripdata.SR_Flag,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone
from fhv_tripdata
inner join dim_zones as pickup_zone
on fhv_tripdata.PUlocationID = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_tripdata.DOlocationID = dropoff_zone.locationid