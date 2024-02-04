from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from pandas import DataFrame
from os import path
import pyarrow as pa
import pyarrow.parquet as pq
import json
import os


if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

config_path = path.join(get_repo_path(), 'io_config.yaml')
config_profile = 'default'

bucket_name = 'terraform-demo-bucket-h1'
table_name = 'nyc-taxi-data'

root_path = f"{bucket_name}/{table_name}"

gcp_credentials = ConfigFileLoader(config_path, config_profile).get("GOOGLE_SERVICE_ACC_KEY")
with open("gcp_credentials.json", "w") as f:
    json.dump(gcp_credentials, f)

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "gcp_credentials.json"


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    gcs = pa.fs.GcsFileSystem()

    table = pa.Table.from_pandas(df)

    pq.write_to_dataset(
        table,
        root_path,
        partition_cols=["lpep_pickup_date"],
        filesystem=gcs,
    )
