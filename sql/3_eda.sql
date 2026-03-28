-- EDA

SELECT *
FROM am_sales2;

SELECT DISTINCT SUBSTRING(order_date,1,7)
FROM am_sales2;

SELECT 
SUBSTRING(order_date,1,7) AS month,
COUNT(*) AS orders,
SUM(amount) AS revenue
FROM am_sales2
GROUP BY month
ORDER BY revenue DESC;

SELECT category,
COUNT(*) AS orders,
SUM(amount) AS revenue,
SUM(qty) AS units
FROM am_sales2
GROUP BY category
ORDER BY revenue DESC;

SELECT 
sku,
SUM(qty) AS units,
SUM(amount) AS revenue
FROM am_sales2
GROUP BY sku
ORDER BY revenue DESC
;

SELECT 
ship_state,
SUM(amount) AS revenue
FROM am_sales2
GROUP BY ship_state
ORDER BY revenue DESC;

SELECT 
ship_city,
SUM(amount) AS revenue
FROM am_sales2
GROUP BY ship_city
ORDER BY revenue DESC;

SELECT 
status,
COUNT(*) AS orders,
SUM(amount) AS revenue
FROM am_sales2
GROUP BY status;

WITH c_mo AS
(
SELECT category,
SUBSTRING(order_date,1,7) AS month,
SUM(amount) AS revenue
FROM am_sales2
GROUP BY month, category
), ranked AS
(
SELECT *,
DENSE_RANK() OVER (PARTITION BY month ORDER BY revenue DESC) AS RANKING
FROM c_mo
)
SELECT *
FROM RANKED
WHERE RANKING <= 5
ORDER BY month;

SELECT 
CASE 
  WHEN amount < 300 THEN '<300'
  WHEN amount BETWEEN 300 AND 600 THEN '300-600'
  ELSE '>600'
END AS bucket,
COUNT(*) AS orders
FROM am_sales2
GROUP BY bucket
ORDER BY orders DESC;









