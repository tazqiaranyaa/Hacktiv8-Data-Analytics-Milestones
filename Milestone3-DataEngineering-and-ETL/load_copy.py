# Import library yang dibutuhkan
from pyspark.sql import SparkSession
from pymongo import MongoClient
from pymongo.server_api import ServerApi

# Inisialisasi Spark
spark = SparkSession.builder.appName("SuperstoreMongoDB").getOrCreate()

# Input file CSV 
df = spark.read.option("header", "true").csv("/opt/airflow/data/superstore.csv")

# ambil 20 baris pertama.
df_20 = df.limit(20)
pandas_df_20 = df_20.toPandas()

# Mengonversi df Pandas menjadi list of dictionaries.
data_dicts_20 = pandas_df_20.to_dict(orient='records')

# input URI ke MongoDB cluster.
uri = "mongodb+srv://mongodb:mongodb@tazqia.vi0o0ki.mongodb.net/?retryWrites=true&w=majority&appName=tazqia"

#  koneksi client ke MongoDB.
client = MongoClient(uri, server_api=ServerApi('1'))

#  database tujuan.
db = client['tazqia']

# Menentukan collection untuk menyimpan data.
collection = db['superstore']

# Menghapus semua data lama di collection agar tidak double.
collection.delete_many({})

# Memasukkan data baru  ke dalam collection MongoDB 
collection.insert_many(data_dicts_20)
spark.stop()
