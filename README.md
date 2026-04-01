# Kimia Farma Big Data Analytics Project

## Project Overview
Project ini merupakan bagian dari Final Task Project-Based Internship Kimia Farma x Rakamin Academy pada posisi Big Data Analytics. Tujuan utama project adalah melakukan analisis kinerja bisnis Kimia Farma periode 2020–2023 menggunakan BigQuery dan Google Looker Studio.

Project ini berfokus pada proses data preparation, data quality checking, pembuatan tabel analisa utama di BigQuery, dan visualisasi dashboard interaktif di Looker Studio.

---

## Objectives
Tujuan dari project ini adalah:
- Mengimpor dataset ke BigQuery
- Melakukan pengecekan kualitas data awal
- Membuat tabel analisa utama sebagai sumber dashboard
- Menghitung metrik bisnis seperti nett sales dan nett profit
- Membuat dashboard analisis performa bisnis Kimia Farma periode 2020–2023

---

## Dataset Used
Dataset yang digunakan dalam project ini:
- `kf_final_transaction`
- `kf_inventory`
- `kf_kantor_cabang`
- `kf_product`

### Data Dictionary Singkat

#### 1. kf_final_transaction
- `transaction_id` : kode transaksi
- `product_id` : kode produk
- `branch_id` : kode cabang
- `customer_name` : nama customer
- `date` : tanggal transaksi
- `price` : harga obat
- `discount_percentage` : persentase diskon
- `rating` : rating transaksi

#### 2. kf_product
- `product_id` : kode produk
- `product_name` : nama produk
- `product_category` : kategori produk
- `price` : harga produk

#### 3. kf_kantor_cabang
- `branch_id` : kode cabang
- `branch_category` : kategori cabang
- `branch_name` : nama cabang
- `kota` : kota cabang
- `provinsi` : provinsi cabang
- `rating` : rating cabang

#### 4. kf_inventory
- `inventory_id` : kode inventory
- `branch_id` : kode cabang
- `product_id` : kode produk
- `product_name` : nama produk
- `opname_stock` : jumlah stok

---

## BigQuery Environment
- **Project ID** : `rakamin-kf-analytics-490214`
- **Dataset** : `kimia_farma`

---

## Data Processing Flow

### 1. Import Dataset ke BigQuery
Keempat file CSV diimpor ke BigQuery dan disimpan sebagai tabel:
- `kf_final_transaction`
- `kf_inventory`
- `kf_kantor_cabang`
- `kf_product`

### 2. Data Quality Check
Dilakukan pengecekan kualitas data awal meliputi:
- jumlah data tiap tabel
- duplikasi `transaction_id`
- null values pada kolom penting
- validasi join key `branch_id` dan `product_id`
- pengecekan format `discount_percentage`

### 3. Membuat Tabel Analisa
Tabel analisa utama bernama `kf_analysis` dibentuk dari:
- `kf_final_transaction` sebagai tabel utama
- join ke `kf_kantor_cabang` menggunakan `branch_id`
- join ke `kf_product` menggunakan `product_id`

Kolom utama dalam `kf_analysis`:
- `transaction_id`
- `date`
- `branch_id`
- `branch_name`
- `kota`
- `provinsi`
- `rating_cabang`
- `customer_name`
- `product_id`
- `product_name`
- `actual_price`
- `discount_percentage`
- `persentase_gross_laba`
- `nett_sales`
- `nett_profit`
- `rating_transaksi`

---

## Business Rules

### Persentase Gross Profit
Aturan gross profit yang digunakan:
- Harga `<= 50.000` → `10%`
- Harga `> 50.000 - 100.000` → `15%`
- Harga `> 100.000 - 300.000` → `20%`
- Harga `> 300.000 - 500.000` → `25%`
- Harga `> 500.000` → `30%`

### Formula
- **Nett Sales** = `price - (price * discount_percentage)`
- **Nett Profit** = `nett_sales * persentase_gross_laba`

> Catatan: Jika `discount_percentage` pada dataset bertipe angka bulat, misalnya `5` untuk `5%`, maka perhitungan diskon dibagi 100 terlebih dahulu.

---

## SQL Files
Repository ini berisi file SQL berikut:
- `01_data_quality_check.sql` → validasi kualitas data awal
- `02_create_kf_analysis.sql` → pembuatan tabel analisa utama

---

## Dashboard Overview
Dashboard dibuat menggunakan Google Looker Studio dengan sumber data utama:
`rakamin-kf-analytics-490214.kimia_farma.kf_analysis`

### Dashboard Components
Dashboard utama mencakup:
- Summary KPI
- Filter control
- Snapshot data
- Perbandingan pendapatan dan profit per tahun
- Top provinsi berdasarkan total transaksi
- Top provinsi berdasarkan nett sales
- Top 5 cabang dengan rating cabang tinggi namun rating transaksi rendah
- Geo map total profit per provinsi

### Additional Insights
Analisis tambahan yang dieksplorasi dalam dashboard:
- Top 5 cabang berdasarkan nett profit
- Bottom 5 cabang berdasarkan nett profit
- Top 5 cabang dengan gap rating terbesar

---

## Key Insights
Beberapa insight utama yang dapat diperoleh dari dashboard:
1. Performa pendapatan dan profit Kimia Farma menunjukkan perbedaan tren dari tahun ke tahun selama periode 2020–2023.
2. Tidak semua provinsi dengan sales tinggi menghasilkan profit yang sebanding.
3. Beberapa cabang memiliki rating cabang tinggi, namun rating transaksi lebih rendah, yang mengindikasikan adanya gap layanan.
4. Cabang dengan nett profit terendah perlu menjadi perhatian untuk evaluasi operasional.
5. Distribusi profit antar provinsi menunjukkan kontribusi wilayah yang berbeda terhadap performa bisnis perusahaan.

---

## Recommendations
Berdasarkan hasil analisis, beberapa rekomendasi bisnis yang dapat diberikan:
- Melakukan evaluasi operasional pada cabang dengan profit rendah
- Meningkatkan kualitas pengalaman transaksi pada cabang dengan gap rating tinggi
- Meninjau strategi diskon pada wilayah dengan sales tinggi namun profit tidak optimal
- Menjadikan cabang dengan profit tinggi sebagai benchmark performa cabang lain

---

## Tools Used
- **Google BigQuery** → data warehouse dan SQL analysis
- **Google Looker Studio** → dashboard visualization
- **GitHub** → dokumentasi query dan project repository

---

## Project Deliverables
- BigQuery SQL script
- Tabel analisa `kf_analysis`
- Dashboard Looker Studio
- Insight dan rekomendasi bisnis
- Final submission presentation

---

## Author
**Nama:** Naufal Althaf Reswara  
**Program:** Project-Based Internship Kimia Farma x Rakamin Academy  
**Role:** Big Data Analytics Intern

---

## Links
- **Dashboard Looker Studio** : https://lookerstudio.google.com/reporting/2b0163fb-0ece-4aec-898b-16245d8b43ac
- **PPT** : https://canva.link/xesevpu7beklxg1
