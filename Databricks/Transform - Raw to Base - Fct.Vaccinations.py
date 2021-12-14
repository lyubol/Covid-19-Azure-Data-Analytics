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
vaccinations_schema = StructType(fields = [
    StructField('Country', StringType(), True),
    StructField('CountryCode', StringType(), True),
    StructField('Date', DateType(), True),
    StructField('TotalVaccinations', IntegerType(), True),
    StructField('PeopleVaccinated', IntegerType(), True),
    StructField('PeopleFullyVaccinated', IntegerType(), True),
    StructField('TotalBoosters', IntegerType(), True),
    StructField('DailyVaccinationsRaw', IntegerType(), True),
    StructField('DailyVaccinations', IntegerType(), True),
    StructField('TotalVaccinationsPerHundred', DoubleType(), True),
    StructField('PeopleVaccinatedPerHundred', DoubleType(), True),
    StructField('PeopleFullyVaccinatedPerHundred', DoubleType(), True),
    StructField('TotalBustersPerHundred', DoubleType(), True),
    StructField('DailyVaccinationsPerMillion', IntegerType(), True),
    StructField('DailyPeopleVaccinated', IntegerType(), True),
    StructField('DailyPeopleVaccinatedPerHundred', DoubleType(), True)
])

# COMMAND ----------

# DBTITLE 1,Read data
vaccinations_raw_df = (spark.read.format('csv')
                                 .option('header', True)
                                 .schema(vaccinations_schema)
                                 .load('/mnt/adlslirkov/covid/raw/Raw_Covid19_Vaccinations.csv'))

display(vaccinations_raw_df)

# COMMAND ----------

# DBTITLE 1,Remove first row (sub-header)
vaccinations_raw_df = vaccinations_raw_df.filter(col('Country') != '#country+name')

# COMMAND ----------

# DBTITLE 1,Drop country codes
# drop codes that do not match any official country code (have more than three digits). These are codes generated for continents and other areas, which are not relavant in the 'CountryCode' column.

codes_to_drop = []

for i in vaccinations_raw_df.select(vaccinations_raw_df.CountryCode).distinct().collect():
    for y in i:
        if len(y) != 3:
            codes_to_drop.append(y)
            
print(codes_to_drop)


vaccinations_raw_df = vaccinations_raw_df.where(~vaccinations_raw_df.CountryCode.isin(codes_to_drop))

# COMMAND ----------

# DBTITLE 1,Create Fct.Deaths dataframe and add key column
fct_vaccinations_df = (vaccinations_raw_df.withColumn('VaccinationsKey', sha2(concat(col('Country'), col('Date')), 256))
                                          .select(
                                              col('VaccinationsKey').alias('VaccinationsKey'),
                                              col('CountryCode').alias('CountryCode'),
                                              col('Date').alias('Date'),
                                              col('TotalVaccinations').alias('TotalVaccinations'),
                                              col('PeopleVaccinated').alias('PeopleVaccinated'),
                                              col('PeopleFullyVaccinated').alias('PeopleFullyVaccinated'),
                                              col('TotalBoosters').alias('TotalBoosters'),
                                              col('DailyVaccinationsRaw').alias('DailyVaccinationsRaw'),
                                              col('DailyVaccinations').alias('DailyVaccinations'),
                                              col('TotalVaccinationsPerHundred').alias('TotalVaccinationsPerHundred'),
                                              col('PeopleVaccinatedPerHundred').alias('PeopleVaccinatedPerHundred'),
                                              col('PeopleFullyVaccinatedPerHundred').alias('PeopleFullyVaccinatedPerHundred'),
                                              col('TotalBustersPerHundred').alias('TotalBustersPerHundred'),
                                              col('DailyVaccinationsPerMillion').alias('DailyVaccinationsPerMillion'),
                                              col('DailyPeopleVaccinated').alias('DailyPeopleVaccinated'),
                                              col('DailyPeopleVaccinatedPerHundred').alias('DailyPeopleVaccinatedPerHundred')))

display(fct_vaccinations_df)

# COMMAND ----------

# DBTITLE 1,Write to 'base'
save_location= "/mnt/adlslirkov/covid/base/Vaccinations/Fct.Vaccinations"
parquet_location = save_location+"temp.folder"
file_location = save_location+'_export.parquet'

fct_vaccinations_df.repartition(1).write.parquet(path=parquet_location, mode="overwrite")

file = dbutils.fs.ls(parquet_location)[-1].path
dbutils.fs.cp(file, file_location)
dbutils.fs.rm(parquet_location, recurse=True)

# COMMAND ----------

output = fct_vaccinations_df.count()

# COMMAND ----------

dbutils.notebook.exit(str(output) + ' rows written')
