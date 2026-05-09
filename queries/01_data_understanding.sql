--DATA UNDERSTANDING--
--CHECK STRUCTURE--
SELECT * FROM aisles LIMIT 10
SELECT * FROM departments LIMIT 10
SELECT * FROM products LIMIT 10
SELECT * FROM orders LIMIT 10
SELECT * FROM order_products_prior LIMIT 10
SELECT * FROM order_products_train LIMIT 10

--CHECK VOLUME & SCOPE DATA--
SELECT COUNT (*) FROM aisles
SELECT COUNT (*) FROM departments
SELECT COUNT (*) FROM products
SELECT COUNT (*) FROM orders
SELECT COUNT (*) FROM order_products_prior
SELECT COUNT (*) FROM order_products_train

SELECT 
    COUNT(DISTINCT user_id) AS total_users,
    MIN(order_number) AS min_order,
    MAX(order_number) AS max_order,
    ROUND(AVG(days_since_prior_order)::NUMERIC, 2) AS avg_days_between_orders
FROM orders;

SELECT 
    AVG(total_products) AS avg_products_per_order,
    MAX(total_products) AS max_products_in_order
FROM (
    SELECT 
        order_id,
        COUNT(product_id) AS total_products
    FROM order_products_prior
    GROUP BY order_id
) AS subquery;

--CHECK MISSING VALUE--
SELECT 
    SUM(CASE WHEN aisle_id IS NULL THEN 1 ELSE 0 END) AS aisle_id_nulls,
    SUM(CASE WHEN aisle IS NULL THEN 1 ELSE 0 END) AS aisle_nulls
FROM aisles;

SELECT 
    SUM(CASE WHEN department_id IS NULL THEN 1 ELSE 0 END) AS department_id_nulls,
    SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS department_nulls
FROM departments;

SELECT 
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS product_name_nulls,
	SUM(CASE WHEN aisle_id IS NULL THEN 1 ELSE 0 END) AS aisle_id_nulls,
	SUM(CASE WHEN department_id IS NULL THEN 1 ELSE 0 END) AS department_id_nulls
FROM products;

SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS user_id_nulls,
	SUM(CASE WHEN eval_set IS NULL THEN 1 ELSE 0 END) AS eval_set_nulls,
	SUM(CASE WHEN order_number IS NULL THEN 1 ELSE 0 END) AS order_number_nulls,
	SUM(CASE WHEN order_dow IS NULL THEN 1 ELSE 0 END) AS order_dow_nulls,
	SUM(CASE WHEN order_hour_of_day IS NULL THEN 1 ELSE 0 END) AS order_hour_of_day,
	SUM(CASE WHEN days_since_prior_order IS NULL THEN 1 ELSE 0 END) AS days_since_prior_order_nulls
FROM orders;

SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
	SUM(CASE WHEN add_to_cart_order IS NULL THEN 1 ELSE 0 END) AS add_to_cart_order_nulls,
	SUM(CASE WHEN reordered IS NULL THEN 1 ELSE 0 END) AS reordered_nulls
FROM order_products_prior;

SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
	SUM(CASE WHEN add_to_cart_order IS NULL THEN 1 ELSE 0 END) AS add_to_cart_order_nulls,
	SUM(CASE WHEN reordered IS NULL THEN 1 ELSE 0 END) AS reordered_nulls
FROM order_products_train;

--CHECK DUPLIACTE DATA--
SELECT COUNT(*) FROM aisles GROUP BY aisle_id, aisle HAVING COUNT(*) > 1
SELECT COUNT(*) FROM departments GROUP BY department_id, department HAVING COUNT(*) > 1
SELECT COUNT(*) FROM products GROUP BY product_id, product_name HAVING COUNT(*) > 1
SELECT COUNT(*) FROM orders GROUP BY order_id HAVING COUNT(*) > 1
SELECT COUNT(*) FROM order_products_prior GROUP BY order_id, product_id HAVING COUNT(*) > 1
SELECT COUNT(*) FROM order_products_train GROUP BY order_id, product_id HAVING COUNT(*) > 1

--CHECK DISTRIBUTION DATA--
SELECT order_hour_of_day, COUNT(order_id) AS total_order_hour 
FROM orders GROUP BY order_hour_of_day

SELECT order_dow, COUNT(order_id) AS total_order_hour 
FROM orders GROUP BY order_dow

--CHECK OUTLIER DATA--
SELECT      
 AVG(total_products) AS avg_products_per_order,    
 STDDEV(total_products) AS stddev_products_in_order 
 FROM 
 	(SELECT order_id, COUNT(product_id) AS total_products
	 FROM order_products_prior
	 GROUP BY order_id ) AS subquery;

SELECT      
COUNT(total_products) AS total_outlier_orders  
FROM 
 	(SELECT order_id, COUNT(product_id) AS total_products
	 FROM order_products_prior
	 GROUP BY order_id ) 
AS subquery
WHERE total_products >32 

SELECT COUNT(DISTINCT order_id) FROM order_products_prior;

WITH total_order_unik AS ( 
	SELECT COUNT(DISTINCT order_id)AS total_orders 
	FROM order_products_prior),
	
total_order_outlier AS (
	SELECT COUNT(*) AS total_outlier_orders 
	FROM ( 
		SELECT order_id, 
		COUNT(product_id) AS total_products 
		FROM order_products_prior GROUP BY order_id ) AS subquery
	WHERE total_products > 32 )
SELECT 
total_outlier_orders, 
total_orders, 
ROUND((total_outlier_orders* 100.0 / total_orders), 2) AS percentage 
FROM total_order_unik, total_order_outlier;

--CHECK RELASI ANTAR TABEL--

SELECT 
COUNT(*)FROM order_products_prior
WHERE product_id NOT IN (SELECT product_id FROM products);

SELECT COUNT(*) 
FROM (SELECT * FROM order_products_prior LIMIT 100000) op
LEFT JOIN orders o ON op.order_id = o.order_id
WHERE o.order_id IS NULL;
