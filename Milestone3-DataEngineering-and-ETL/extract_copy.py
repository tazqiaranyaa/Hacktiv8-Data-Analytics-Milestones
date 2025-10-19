from pyspark.sql import SparkSession
import os
import shutil
import glob

# === 1. Inisialisasi SparkSession ===
spark = SparkSession.builder \
    .appName("SuperstoreLoad") \
    .getOrCreate()

# === 2. Path input & output di folder Airflow ===
input_file = "/opt/airflow/data/superstore_data.csv"
temp_dir = "/opt/airflow/data/superstore_raw_temp"
final_file = "/opt/airflow/data/superstore_raw.csv"

# Debug: cek apakah file input ada
if not os.path.exists(input_file):
    raise FileNotFoundError(f"File tidak ditemukan: {input_file}")

# === 3. Baca CSV pakai Spark ===
df = spark.read.csv(input_file, header=True, inferSchema=True)

# === 4. Simpan ulang sebagai 1 file CSV (sementara folder) ===
if os.path.exists(temp_dir):
    shutil.rmtree(temp_dir)

df.coalesce(1).write.csv(temp_dir, header=True, mode="overwrite")

# === 5. Rename part-file jadi single CSV ===
part_file = glob.glob(os.path.join(temp_dir, "part-*.csv"))[0]
shutil.move(part_file, final_file)

# Hapus folder temporary
shutil.rmtree(temp_dir)

print("File berhasil disimpan:", final_file)