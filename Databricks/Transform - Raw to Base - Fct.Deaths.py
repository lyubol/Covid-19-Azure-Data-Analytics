# Databricks notebook source
# DBTITLE 1,Imports
from pyspark.sql.types import (StructType, 
                               StructField, 
                               StringType, 
                               IntegerType, 
                               DoubleType, 
                               DateType)

from pyspark.sql.functions import (concat, coalesce, max, sha2, col)

from pyspark.sql.utils import AnalysisException

# COMMAND ----------

# DBTITLE 1,Create schema
# schema is used when reading the raw csv file
deaths_schema = StructType(fields = [
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
deaths_raw_df = (spark.read.format('csv')
                           .option('header', True)
                           .schema(deaths_schema)
                           .load('/mnt/adlslirkov/covid/raw/Raw_Covid19_Deaths.csv'))

display(deaths_raw_df)

# COMMAND ----------

# DBTITLE 1,Replace nulls in 'Province/State'
deaths_raw_df = (deaths_raw_df.fillna('Unknown', 'Province/State')
                              .fillna(-1, 'IntermediateRegionCode'))

display(deaths_raw_df)

# COMMAND ----------

# DBTITLE 1,Replace nulls in 'Province/State'
# replacing 'Taiwan*' with 'Taiwan'
deaths_raw_df = deaths_raw_df.replace('Taiwan*', 'Taiwan', subset='Country/Region')

# drop values, which are not country names
deaths_raw_df = deaths_raw_df.where((deaths_raw_df['Country/Region'] != 'Summer Olympics 2020') & (deaths_raw_df['Country/Region'] != 'Diamond Princess') & (deaths_raw_df['Country/Region'] != 'MS Zaandam'))

# COMMAND ----------

# DBTITLE 1,Remove first row (sub-header)
deaths_raw_df = deaths_raw_df.filter(col('Country/Region') != '#country+name')

# COMMAND ----------

# DBTITLE 1,Create Fct.Deaths dataframe and add key column
fct_deaths_df = (deaths_raw_df.groupBy('Date', 'Country/Region').sum('Value')
                              .withColumn('DeathsKey', sha2(concat(col('Country/Region'), col('Date')), 256))
                              .select(
                                  col('DeathsKey').alias('DeathsKey'),
                                  col('Country/Region').alias('Country/Region'),
                                  col('Date').alias('Date'),
                                  col('sum(Value)').alias('Value')))

display(fct_deaths_df)

# COMMAND ----------

# DBTITLE 1,Write to 'base'
save_location= "/mnt/adlslirkov/covid/base/Deaths/Fct.Deaths"
parquet_location = save_location+"temp.folder"
file_location = save_location+'_export.parquet'

fct_deaths_df.repartition(1).write.parquet(path=parquet_location, mode="overwrite")

file = dbutils.fs.ls(parquet_location)[-1].path
dbutils.fs.cp(file, file_location)
dbutils.fs.rm(parquet_location, recurse=True)

# COMMAND ----------

output = fct_deaths_df.count()

# COMMAND ----------

dbutils.notebook.exit(str(output) + ' rows written')
