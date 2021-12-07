# Databricks notebook source
# DBTITLE 1,Imports
from pyspark.sql.types import (StructType, 
                               StructField, 
                               StringType, 
                               IntegerType, 
                               DoubleType, 
                               DateType)

from pyspark.sql.functions import (concat_ws, coalesce, max)

from pyspark.sql.utils import AnalysisException

# COMMAND ----------

# DBTITLE 1,Create schema
# schema is used when reading the raw csv file
cases_schema = StructType(fields = [
    StructField('Province/State', StringType(), True),
    StructField('Country/Region', StringType(), True),
    StructField('Lat', DoubleType(), True),
    StructField('Long', DoubleType(), True),
    StructField('Date', DateType(), True),
    StructField('Value', IntegerType(), True),
    StructField('CountryCode', StringType(), True),
    StructField('RegionCode', IntegerType(), True),
    StructField('SubRegionCode', IntegerType(), True),
    StructField('IntermediateRegionCode', IntegerType(), True),
])

# schema is used if the read location of the base parquet file is empty
empty_schema_base_df = StructType(fields = [
    StructField('Key', StringType(), True),
    StructField('Province/State', StringType(), True),
    StructField('Country/Region', StringType(), True),
    StructField('Lat', DoubleType(), True),
    StructField('Long', DoubleType(), True),
    StructField('Date', DateType(), True),
    StructField('Value', IntegerType(), True),
    StructField('CountryCode', StringType(), True),
    StructField('RegionCode', IntegerType(), True),
    StructField('SubRegionCode', IntegerType(), True),
    StructField('IntermediateRegionCode', IntegerType(), True),
])

# COMMAND ----------

# DBTITLE 1,Read data
# If location is empty (e.g notebook runs for the first time) then load empty schema. 
try:
   base_df = spark.read.format('parquet').option('header', True).load('/mnt/adlslirkov/covid/base/Covid19_Cases')
except AnalysisException:
    base_df = spark.read.format('parquet').schema(empty_schema_base_df).load()

cases_raw_df = (spark.read.format('csv')
                          .option('header', True)
                          .schema(cases_schema)
                          .load('/mnt/adlslirkov/covid/raw/Raw_Covid19_Cases.csv'))

display(cases_raw_df)

# COMMAND ----------

# DBTITLE 1,Replace nulls in 'Province/State'
cases_raw_df = (cases_raw_df.fillna('Unknown', 'Province/State')
                            .fillna(-1, 'IntermediateRegionCode'))

display(cases_raw_df)

# COMMAND ----------

# DBTITLE 1,Create 'Key' column
cases_raw_df = cases_raw_df.withColumn('Key', concat_ws('-', cases_raw_df['CountryCode'], cases_raw_df['Date'].cast('String'))) 

display(cases_raw_df)

# COMMAND ----------

# DBTITLE 1,Remove first row (sub-header)
cases_raw_df = cases_raw_df.filter(cases_raw_df.Key != '#country+code')

# COMMAND ----------

# DBTITLE 1,Reorder columns
cases_raw_df = cases_raw_df.select('Key', 'Province/State', 'Country/Region', 'Lat', 'Long', 'Date', 'Value', 'CountryCode', 'RegionCode', 'SubRegionCode', 'IntermediateRegionCode')

# COMMAND ----------

# DBTITLE 1,Append new rows only
# take all rows in cases_raw_df that are not in base_df, so they can be later appended

append_df = cases_raw_df.exceptAll(base_df)

# COMMAND ----------

# DBTITLE 1,Count of rows to be appended
output = append_df.count()

# COMMAND ----------

# DBTITLE 1,Write to 'base'
append_df.write.mode('append').format('parquet').save('/mnt/adlslirkov/covid/base/Covid19_Cases')

# COMMAND ----------

dbutils.notebook.exit(str(output) + ' rows appended')
