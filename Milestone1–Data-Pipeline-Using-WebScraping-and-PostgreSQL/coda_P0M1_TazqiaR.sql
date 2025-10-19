---- Milestone 1
-- Nama   : Tazqia Ranyanisha
-- Batch  : CODA-RMT-008

-- Program ini dibuat untuk menganalisis data produk kecantikan dari Sociolla, 
-- dengan tujuan mengidentifikasi produk-produk terbaik berdasarkan performa penjualan, 
-- potensi keuntungan (melalui diskon tinggi), dan preferensi pasar (dilihat dari review).
-- Analisis ini dapat menjadi dasar pengambilan keputusan strategis sebagai calon reseller.

---1. Create table
CREATE TABLE sociolla (
    brand TEXT,
    product_name TEXT,
    rating FLOAT,
    review INT,
    discount TEXT,
    price_after_discount INT,
    price_before_discount INT,
    makeup_type TEXT
);


---2. Input data
COPY public.sociolla (
    brand,
    product_name,
    rating,
    review,
    discount,
    price_after_discount,
    price_before_discount,
    makeup_type
)
FROM '/tmp/coda_P0M1_TazqiaR.csv'
DELIMITER E','  
CSV HEADER;

---3. Normalisasi  1NF (First Normal Form)
---Sudah ok, karena tidak ada kolom yang berisi data bertingkat/array/berulang.

---4. Normalisasi 2NF (Second Normal Form) agar tidak ada partial dependency dari composite key.
---Jadikan: (i) product_id sebagai primary key, (ii) pisahkan brand dan makeup_type ke tabel sendiri.
---4.1 Membuat table
CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name TEXT UNIQUE
);

--4.2 Membuat tabel makeup_type
CREATE TABLE makeup_type (
    type_id SERIAL PRIMARY KEY,
    makeup_type TEXT UNIQUE
);

-- 4.3 Membuat tabel utama produk (mengacu ke brand dan makeup_type)
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    brand_id INT REFERENCES brand(brand_id),
    type_id INT REFERENCES makeup_type(type_id),
    rating FLOAT,
    review INT,
    discount FLOAT,
    price_after_discount INT,
    price_before_discount INT
);


---5. Normalisasi 3NF (Third Normal Form) agar tidak  ada ketergantungan transitif.
-- Sudah terpenuhi karena:
-- a) Tidak ada kolom non-key yang bergantung ke kolom non-key lainnya
-- b) Semua ketergantungan langsung ke kunci primer (product_id)
-- c) brand dan makeup_type dipisah ke tabel sendiri

---6. Masukkan data referensi (brand & makeup_type)
---6.1 Masukkan data ke tabel brand & makeup_type
-- Pastikan tidak ada null
INSERT INTO brand (brand_name)
SELECT DISTINCT TRIM(brand)
FROM sociolla
WHERE brand IS NOT NULL;

INSERT INTO makeup_type (makeup_type)
SELECT DISTINCT TRIM(makeup_type)
FROM sociolla
WHERE makeup_type IS NOT NULL;

---6.2 Masukkan data ke tabel product
INSERT INTO product (
    product_name, rating, review, discount, 
    price_after_discount, price_before_discount, 
    brand_id, type_id
)
SELECT 
    s.product_name,
    s.rating,
    s.review,
    s.discount,
    s.price_after_discount,
    s.price_before_discount,
    b.brand_id,
    m.type_id
FROM sociolla s
JOIN brand b ON TRIM(s.brand) = b.brand_name
JOIN makeup_type m ON TRIM(s.makeup_type) = m.makeup_type;

---Validasi dan cek hasil-------
SELECT * from sociolla

--Cek isi table brand:
SELECT * FROM brand;

--Cek isi table makeup type:
SELECT * FROM makeup_type;

--Cek isi tabel product:
SELECT * FROM product;

--Cek hasil join lengkap:
SELECT 
    p.product_id,
    p.product_name,
    b.brand_name,
    m.makeup_type,
    p.rating,
    p.review,
    p.discount,
    p.price_after_discount,
    p.price_before_discount
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN makeup_type m ON p.type_id = m.type_id;


---Analisis & ekstrak data sebagai calon reseller product dari Sociolla
---1. Top Produk Paling Menguntungkan (High Discount + High Rating)
SELECT 
    p.product_name,
    b.brand_name,
    m.makeup_type,
    p.discount,
    p.review,
    p.price_before_discount,
    p.price_after_discount,
    ROUND((p.price_before_discount - p.price_after_discount)::NUMERIC, 2) AS potential_margin
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN makeup_type m ON p.type_id = m.type_id
ORDER BY p.discount DESC, p.review DESC
LIMIT 1;
---Jawaban: "BBIA Last Auto Gel Eyeliner Slim"

---2. Produk Harga Terjangkau namun Review Tinggi
SELECT 
    p.product_name,
    b.brand_name,
    m.makeup_type,
    p.price_after_discount,
    p.review,
    p.discount
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN makeup_type m ON p.type_id = m.type_id
WHERE p.price_after_discount <= 100000
ORDER BY p.review DESC, p.discount DESC;
---Jawaban: "Fix On Vibe Brow"

---3. Produk Best-Performing di Tiap Brand
SELECT DISTINCT ON (b.brand_name)
    b.brand_name,
    p.product_name,
    m.makeup_type,
    p.review,
    p.discount,
    p.price_after_discount
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN makeup_type m ON p.type_id = m.type_id
ORDER BY b.brand_name, p.review DESC;




