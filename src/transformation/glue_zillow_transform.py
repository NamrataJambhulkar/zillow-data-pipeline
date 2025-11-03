import sys
import traceback
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql import functions as F
from pyspark.sql.types import DoubleType, IntegerType, StringType, LongType
from pyspark.sql.window import Window
from awsglue.dynamicframe import DynamicFrame

# --- Glue setup ---
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# --- Config ---
RAW_S3_PATH = "s3://zillow-raw-data-3010/"
OUTPUT_S3_PATH = "s3://zillow-processed-data-3010/"
GLUE_DATABASE = "zillow_db"
GLUE_TABLE = "zillow_processed"
PARTITION_KEYS = ["city", "status", "ingestion_date"]

try:
    print(f"Starting job: {args['JOB_NAME']}")
    print(f"Reading JSON data from {RAW_S3_PATH}")

    # Read JSON
    df_raw = spark.read.option("multiline", "true").json(RAW_S3_PATH)

    # Explode the 'data.results' array
    df_exploded = df_raw.withColumn("result", F.explode(F.col("data.results")))

    # Flatten the nested structure
    df_flat = df_exploded.select(
        F.col("city"),
        F.col("status"),
        F.col("result.bathrooms").alias("bathrooms"),
        F.col("result.bedrooms").alias("bedrooms"),
        F.col("result.city").alias("property_city"),
        F.col("result.state").alias("property_state"),
        F.col("result.streetAddress").alias("address"),
        F.col("result.unit").alias("unit"),
        F.col("result.zipcode").alias("zipcode"),
        F.col("result.price").alias("price"),
        F.col("result.zestimate").alias("zestimate"),
        F.col("result.homeType").alias("home_type"),
        F.col("result.livingArea").alias("area_sqft"),
        F.col("result.lotAreaValue").alias("lot_area"),
        F.col("result.lotAreaUnit").alias("lot_unit"),
        F.col("result.latitude").alias("latitude"),
        F.col("result.longitude").alias("longitude"),
        F.col("result.imgSrc").alias("image_url"),
        F.col("result.listing_sub_type.is_openHouse").alias("is_open_house"),
        F.col("result.timeOnZillow").alias("time_on_zillow"),
        F.col("result.zpid").alias("zpid")
    )

    # Clean and normalize data types
    df_clean = (
        df_flat
        .withColumn("price", F.col("price").cast(DoubleType()))
        .withColumn("zestimate", F.col("zestimate").cast(DoubleType()))
        .withColumn("bedrooms", F.col("bedrooms").cast(IntegerType()))
        .withColumn("bathrooms", F.col("bathrooms").cast(DoubleType()))
        .withColumn("area_sqft", F.col("area_sqft").cast(IntegerType()))
        .withColumn("latitude", F.col("latitude").cast(DoubleType()))
        .withColumn("longitude", F.col("longitude").cast(DoubleType()))
        .withColumn("zipcode", F.col("zipcode").cast(StringType()))
        .withColumn("zpid", F.col("zpid").cast(LongType()))
        .withColumn("ingestion_date", F.current_date())
    )

    # Drop incomplete or duplicate records
    df_clean = df_clean.dropna(subset=["price", "address"])
    df_clean = df_clean.dropDuplicates(["zpid"])
    
     # Merge with old data if available
    try:
        df_old = spark.read.parquet(OUTPUT_S3_PATH)
        print("✅ Existing processed data found, merging...")
        df_combined = df_old.unionByName(df_clean, allowMissingColumns=True)
    except Exception:
        print("ℹ️ No previous data found. Creating fresh dataset.")
        df_combined = df_clean

    # Keep only the latest record for each property
    window_spec = Window.partitionBy("zpid").orderBy(F.col("ingestion_date").desc())
    df_final = (
        df_combined
        .withColumn("row_num", F.row_number().over(window_spec))
        .filter(F.col("row_num") == 1)
        .drop("row_num")
    )

    # Write final dataset
    dyf = DynamicFrame.fromDF(df_final, glueContext, "dyf")
    glueContext.write_dynamic_frame.from_options(
        frame=dyf,
        connection_type="s3",
        connection_options={
            "path": OUTPUT_S3_PATH,
            "partitionKeys": PARTITION_KEYS,
            "enableUpdateCatalog": True,
            "updateBehavior": "UPDATE_IN_DATABASE"
        },
        format="parquet",
        format_options={"compression": "snappy", "mergeSchema": True}
    )

    print("✅ New records appended successfully.")
    job.commit()

except Exception as e:
    print("❌ Job failed.")
    traceback.print_exc()
    try:
        job.commit()
    except:
        pass
    raise