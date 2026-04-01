-- 1. Cek jumlah data tiap tabel
SELECT 'kf_final_transaction' AS table_name, COUNT(*) AS total_rows
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_final_transaction`
UNION ALL
SELECT 'kf_inventory', COUNT(*)
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_inventory`
UNION ALL
SELECT 'kf_kantor_cabang', COUNT(*)
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_kantor_cabang`
UNION ALL
SELECT 'kf_product', COUNT(*)
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_product`;

-- 2. Cek duplikasi transaction_id
SELECT
  transaction_id,
  COUNT(*) AS total_duplicate
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_final_transaction`
GROUP BY transaction_id
HAVING COUNT(*) > 1
ORDER BY total_duplicate DESC;

-- 3. Cek null values pada field penting transaksi
SELECT
  COUNTIF(transaction_id IS NULL) AS null_transaction_id,
  COUNTIF(product_id IS NULL) AS null_product_id,
  COUNTIF(branch_id IS NULL) AS null_branch_id,
  COUNTIF(customer_name IS NULL) AS null_customer_name,
  COUNTIF(date IS NULL) AS null_date,
  COUNTIF(price IS NULL) AS null_price,
  COUNTIF(discount_percentage IS NULL) AS null_discount_percentage,
  COUNTIF(rating IS NULL) AS null_rating
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_final_transaction`;

-- 4. Cek null values pada field penting cabang
SELECT
  COUNTIF(branch_id IS NULL) AS null_branch_id,
  COUNTIF(branch_name IS NULL) AS null_branch_name,
  COUNTIF(kota IS NULL) AS null_kota,
  COUNTIF(provinsi IS NULL) AS null_provinsi,
  COUNTIF(rating IS NULL) AS null_rating
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_kantor_cabang`;

-- 5. Cek null values pada field penting produk
SELECT
  COUNTIF(product_id IS NULL) AS null_product_id,
  COUNTIF(product_name IS NULL) AS null_product_name,
  COUNTIF(price IS NULL) AS null_price
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_product`;

-- 6. Cek sample discount_percentage untuk memastikan format persen/desimal
SELECT
  transaction_id,
  price,
  discount_percentage
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_final_transaction`
LIMIT 20;

-- 7. Cek apakah semua branch_id transaksi tersedia di tabel cabang
SELECT
  COUNTIF(kc.branch_id IS NULL) AS branch_not_found
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-490214.kimia_farma.kf_kantor_cabang` kc
  ON t.branch_id = kc.branch_id;

-- 8. Cek apakah semua product_id transaksi tersedia di tabel produk
SELECT
  COUNTIF(p.product_id IS NULL) AS product_not_found
FROM `rakamin-kf-analytics-490214.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-490214.kimia_farma.kf_product` p
  ON t.product_id = p.product_id;
