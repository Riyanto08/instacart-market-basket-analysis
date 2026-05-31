--BASKET ANALYSIS (CORE)--
SELECT a.order_id, a.product_name AS product_a, b.product_name AS product_b
FROM analytical_dataset a
JOIN analytical_dataset b ON a.order_id=b.order_id
WHERE a.product_name < b.product_name
LIMIT 10