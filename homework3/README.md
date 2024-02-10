# Week 3 Homework

Setup scritp is at setup.py, this script downloads the green taxi data and uploads to a bucket in GCP.

Then a external table ins created in Big Query.
```   de-course-412517
CREATE OR REPLACE EXTERNAL TABLE `de-course-412517.green_taxi.external_green_tripdata`
OPTIONS (
 format = 'PARQUET',
 uris = ['gs://my-course-bucket-h3/green/*.parquet']
);
```

The a Big Query is created
```
CREATE OR REPLACE TABLE de-course-412517.green_taxi.no_external_green_tripdata AS
SELECT * FROM de-course-412517.green_taxi.external_green_tripdata;
```

## Question 1
```
SELECT COUNT(*) FROM de-course-412517.green_taxi.external_green_tripdata;
```

## Question 2
Count the distinct number of PULocationIDs for the entire dataset external table
```
SELECT COUNT(DISTINCT(PULocationID))
FROM de-course-412517.green_taxi.no_external_green_tripdata;
```
Same count on materized table
```
SELECT COUNT(DISTINCT(PULocationID))
FROM de-course-412517.green_taxi.external_green_tripdata;
```

## Question 3
```
SELECT COUNT(DISTINCT(PULocationID))
FROM de-course-412517.green_taxi.external_green_tripdata WHERE fare_amount = 0;
```

## Question 4
```
CREATE OR REPLACE TABLE de-course-412517.green_taxi.green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM de-course-412517.green_taxi.no_external_green_tripdata;
``` 

## Question 5
Distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022
```
SELECT DISTINCT(PULocationID)
FROM de-course-412517.green_taxi.green_tripdata_partitoned_clustered
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
```

## Question 8
```
SELECT COUNT(*) FROM de-course-412517.green_taxi.external_green_tripdata;
```