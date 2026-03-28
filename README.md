# 📊 Amazon Sales Data Analysis (SQL Project)

## 📌 Overview
This project analyzes an e-commerce sales dataset using SQL.  
The goal is to clean raw transactional data and extract business insights such as revenue trends, product performance, and geographic distribution.

---
## 📂 Project Structure

amazon-sales-sql-project/
│
├── sql/
│   ├── 1_data_import.sql
│   ├── 2_data_cleaning.sql
│   └── 3_eda.sql
│
├── sales.csv
└── README.md

## 🛠️ Tools
- MySQL (MySQL Workbench)
- SQL (Data Cleaning & Analysis)

---

## 📂 Dataset
- Source: Amazon Sales Dataset (Kaggle)
- Size: ~128,000 rows
- Fields include:
  - Order ID, Date, Status
  - Product (SKU, Category, Size)
  - Revenue (Amount, Quantity)
  - Location (City, State)

---

## 🧹 Data Cleaning Steps
- Removed duplicates using `ROW_NUMBER()`
- Standardized text (city, state, category)
- Converted data types:
  - `order_date` → DATE
  - `qty` → INT
  - `amount` → DECIMAL
- Handled missing values (NULL replacement)
- Trimmed and formatted postal codes
- Dropped unnecessary columns

---

## 📊 Exploratory Data Analysis (EDA)

### 🔹 Revenue Trends
- Monthly revenue aggregation 
- Identified peak sales periods

### 🔹 Product Performance
- Top-selling SKUs by revenue and quantity
- Category-level revenue analysis

### 🔹 Geographic Analysis
- Revenue distribution by state and city
- Identified key markets

### 🔹 Order Status Analysis
- Distribution of shipped vs cancelled orders

### 🔹 Advanced SQL
- Used window functions (`DENSE_RANK`) to rank top categories per month

---

## 📈 Key Insights
- Revenue is concentrated in a few key states (e.g., Maharashtra, Uttar Pradesh)
- The *kurta* category dominates total sales
- A small number of SKUs drive a large portion of revenue
- Most orders are successfully shipped, indicating strong fulfillment performance
- Monthly revenue peaked in May 2022
- Most orders fall in price range 300–600 INR

## Setup Instructions

1. Download `sales.csv`
2. Move it to:
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
3. Run `1_data_import.sql`


