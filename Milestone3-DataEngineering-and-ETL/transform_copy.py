from pyspark.sql import SparkSession
from pyspark.sql.functions import lit, col
import os
import shutil
import glob

# === 1. Inisialisasi SparkSession ===
spark = SparkSession.builder \
    .appName("SuperstoreTransform") \
    .getOrCreate()

# === 2. Path input & output (sesuai folder Airflow) ===
input_file = "/opt/airflow/data/superstore_raw.csv"
temp_dir = "/opt/airflow/data/superstore_temp"
final_file = "/opt/airflow/data/superstore.csv"

# Debug: pastikan file input ada
if not os.path.exists(input_file):
    raise FileNotFoundError(f"File tidak ditemukan: {input_file}")

# === 3. Baca CSV ===
df = spark.read.csv(input_file, header=True, inferSchema=True)

print("Schema awal:")
df.printSchema()
print("Jumlah baris awal:", df.count())

# === 4. Transformasi data ===
# Drop rows dengan Income null
df = df.dropna(subset=['Income'])

# Tambah kolom Age (2025 - Year_Birth)
df = df.withColumn("Age", lit(2025) - col("Year_Birth"))

# Drop kolom Year_Birth
df = df.drop("Year_Birth")

# Filter: drop semua baris dengan Age > 95
df = df.filter(col("Age") <= 95)

print("Schema setelah transformasi:")
df.printSchema()
print("Jumlah baris akhir:", df.count())

# === 5. Simpan ulang sebagai single CSV ===
if os.path.exists(temp_dir):
    shutil.rmtree(temp_dir)

df.coalesce(1).write.csv(temp_dir, header=True, mode="overwrite")

# Rename part file jadi superstore.csv
part_file = glob.glob(os.path.join(temp_dir, "part-*.csv"))[0]
shutil.move(part_file, final_file)

# Hapus folder sementara
shutil.rmtree(temp_dir)

print("File berhasil disimpan:", final_file)
