import requests
import os

from google.cloud import storage

bucket_name = os.environ.get("MY_GCS_BUCKET")

def upload_to_gcs(bucket, object_name, local_file):
   client = storage.Client()
   bucket = client.bucket(bucket)
   blob = bucket.blob(object_name)
   blob.upload_from_filename(local_file)

def upload_taxi_data(year, color):
   for month in range(1, 13):
       requested_url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/{color}_tripdata_{year}-{month:02d}.parquet"
       content = requests.get(requested_url)
       path_file = f"green_tripdata_2022-{month:02d}.parquet"
       open(path_file, "wb").write(content.content)
       upload_to_gcs(bucket_name, f"{color}/{path_file}", path_file)

upload_taxi_data("2022", "green")
