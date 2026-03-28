-- =========================
-- SETUP DATABASE
-- =========================
CREATE DATABASE IF NOT EXISTS sales_data;
USE sales_data;

-- =========================
-- RESET TABLE (BIAR BISA DI-RERUN)
-- =========================
DROP TABLE IF EXISTS amazon_sales;

-- =========================
-- CREATE TABLE
-- =========================
CREATE TABLE amazon_sales (
  idx TEXT,
  order_id TEXT,
  order_date TEXT,
  status TEXT,
  fulfillment TEXT,
  sales_channel TEXT,
  ship_service_level TEXT,
  style TEXT,
  sku TEXT,
  category TEXT,
  size TEXT,
  asin TEXT,
  courier_status TEXT,
  qty TEXT,
  currency TEXT,
  amount TEXT,
  ship_city TEXT,
  ship_state TEXT,
  ship_postal_code TEXT,
  ship_country TEXT,
  promotion_ids TEXT,
  b2b TEXT,
  fulfilled_by TEXT,
  extra_col TEXT
);

-- =========================
-- LOAD DATA
-- =========================
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales.csv'
INTO TABLE amazon_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- =========================
-- CHECK
-- =========================
SELECT COUNT(*) AS total_rows FROM amazon_sales;