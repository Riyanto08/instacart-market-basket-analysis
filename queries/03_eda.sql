--EDA--
--CUSTOMER BEHAVIOR--
SELECT COUNT(order_id) AS jumlah_order, order_dow, order_hour_of_day 
FROM analytical_dataset 
GROUP BY order_dow, order_hour_of_day
ORDER BY jumlah_order DESC

SELECT COUNT(order_id) AS jumlah_order, order_dow, order_hour_of_day 
FROM analytical_dataset 
GROUP BY order_dow, order_hour_of_day
ORDER BY jumlah_order ASC

--FREKUENSI PERORDER--
SELECT COUNT(DISTINCT(order_id)) AS jumlah_order,user_id 
FROM analytical_dataset
GROUP BY user_id 
ORDER BY jumlah_order DESC

SELECT AVG(jumlah_order) AS rata_rata_order
FROM (
SELECT COUNT(DISTINCT(order_id)) AS jumlah_order,user_id 
FROM analytical_dataset
GROUP BY user_id 
ORDER BY jumlah_order DESC
) AS subquery;

WITH total_produk AS (
    SELECT COUNT(*) AS total_produk 
    FROM analytical_dataset
),
total_reorder AS (
    SELECT COUNT(reordered) AS total_reorder 
    FROM analytical_dataset 
    WHERE reordered = true
)
SELECT 
    total_produk,
    total_reorder,
    ROUND(total_reorder * 100.0 / total_produk, 2) AS percentage_reorder
FROM total_produk, total_reorder;

--PRODUCT INISGHT--
SELECT product_name, COUNT(product_name) AS jumlah_kemunculan 
FROM analytical_dataset 
GROUP BY product_name 
ORDER BY jumlah_kemunculan DESC 
LIMIT 10