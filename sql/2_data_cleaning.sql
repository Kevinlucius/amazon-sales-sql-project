
USE sales_data;

SELECT *
FROM amazon_sales;

CREATE TABLE am_sales
LIKE amazon_sales;

SELECT *
FROM am_sales;

INSERT am_sales
SELECT *
FROM amazon_sales;

-- REMOVE DUPES
SELECT *,
ROW_NUMBER() OVER (PARTITION BY order_id, order_date, `status`, style, sku, asin) AS row_num
FROM am_sales;

WITH dup_cte AS
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY order_id, order_date, `status`, style, sku, asin) AS row_num
FROM am_sales
)
SELECT *
FROM dup_cte
WHERE row_num > 1;

SELECT *
FROM am_sales
WHERE order_id =  '171-3249942-2207542';

CREATE TABLE `am_sales2` (
  `idx` text,
  `order_id` text,
  `order_date` text,
  `status` text,
  `fulfillment` text,
  `sales_channel` text,
  `ship_service_level` text,
  `style` text,
  `sku` text,
  `category` text,
  `size` text,
  `asin` text,
  `courier_status` text,
  `qty` text,
  `currency` text,
  `amount` text,
  `ship_city` text,
  `ship_state` text,
  `ship_postal_code` text,
  `ship_country` text,
  `promotion_ids` text,
  `b2b` text,
  `fulfilled_by` text,
  `extra_col` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE am_sales2
ADD COLUMN row_num INT;

INSERT INTO am_sales2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY order_id, order_date, `status`, style, sku, asin) AS row_num
FROM am_sales;

SELECT *
FROM am_sales2
WHERE row_num > 1;

delete
FROM am_sales2
WHERE row_num > 1;

-- REMOVE BLANKS

UPDATE am_sales2
SET
status = NULLIF(TRIM(status), ''),
fulfillment = NULLIF(TRIM(fulfillment), ''),
sales_channel = NULLIF(TRIM(sales_channel), ''),
ship_service_level = NULLIF(TRIM(ship_service_level), ''),
style = NULLIF(TRIM(style), ''),
sku = NULLIF(TRIM(sku), ''),
category = NULLIF(TRIM(category), ''),
size = NULLIF(TRIM(size), ''),
asin = NULLIF(TRIM(asin), ''),
amount = NULLIF(TRIM(amount), ''),
courier_status = NULLIF(TRIM(courier_status), ''),
currency = NULLIF(TRIM(currency), ''),
ship_city = NULLIF(TRIM(ship_city), ''),
ship_state = NULLIF(TRIM(ship_state), ''),
ship_postal_code = NULLIF(TRIM(ship_postal_code), ''),
ship_country = NULLIF(TRIM(ship_country), ''),
promotion_ids = NULLIF(TRIM(promotion_ids), ''),
fulfilled_by = NULLIF(TRIM(fulfilled_by), '')
;

SELECT *
FROM am_sales2;

-- STANDARDIZE DATA
SELECT ship_city, LOWER(ship_city), ship_state, UPPER(ship_state), category, LOWER(category)
FROM am_sales2;

UPDATE am_sales2
SET ship_city = LOWER(ship_city),
 ship_state = UPPER(ship_state),
 category = LOWER(category);

SELECT order_date,
 STR_TO_DATE(order_date, '%m-%d-%y')
FROM am_sales2;

UPDATE am_sales2
SET order_date =  STR_TO_DATE(order_date, '%m-%d-%y');

ALTER TABLE am_sales2
MODIFY COLUMN order_date DATE;

ALTER TABLE am_sales2
MODIFY qty INT;

ALTER TABLE am_sales2
MODIFY amount DECIMAL(10,2);

SELECT DISTINCT `status`
FROM am_sales2
WHERE `status` LIKE 'Ship%'
OR `status` LIKE 'Pending%';

UPDATE am_sales2
SET `status` = 'Shipped'
WHERE `status` LIKE 'Ship%';
UPDATE am_sales2
set `status` = 'Pending'
WHERE `status` LIKE 'Pending%' ;

SELECT ship_postal_code, LEFT(ship_postal_code,6)
FROM am_sales2;

UPDATE am_sales2
SET ship_postal_code = LEFT(ship_postal_code,6);

SELECT *
FROM am_sales2;


-- remove columns

SELECT ship_country
FROM am_sales2
where ship_country != 'IN' ;

ALTER TABLE am_sales2
DROP COLUMN extra_col , DROP COLUMN row_num, DROP COLUMN ship_country;
