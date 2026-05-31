--BASKET ANALYSIS (CORE)--
SELECT a.order_id, a.product_name AS product_a, b.product_name AS product_b
FROM analytical_dataset a
JOIN analytical_dataset b ON a.order_id=b.order_id
WHERE a.product_name < b.product_name
LIMIT 10

--SUPPORT--
WITH top_10_product AS (
    SELECT product_name, COUNT(product_name) AS jumlah_kemunculan
    FROM analytical_dataset
    GROUP BY product_name
    ORDER BY jumlah_kemunculan DESC
    LIMIT 10
),
total_orders AS (
    SELECT COUNT(DISTINCT order_id) AS total
    FROM analytical_dataset
)
SELECT 
    a.product_name AS product_a,
    b.product_name AS product_b,
    COUNT(*) AS frequency,
    total,
    ROUND(COUNT(*) * 1.0 / total, 4) AS support
FROM analytical_dataset a
JOIN analytical_dataset b ON a.order_id = b.order_id
CROSS JOIN total_orders
WHERE a.product_name IN (SELECT product_name FROM top_10_product)
    AND b.product_name IN (SELECT product_name FROM top_10_product)
    AND a.product_name < b.product_name
GROUP BY product_a, product_b, total
ORDER BY frequency DESC;