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

--CONFIDENCE--
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
),
product_freq AS (
    SELECT product_name, COUNT(DISTINCT order_id) AS freq
    FROM analytical_dataset
    WHERE product_name IN (SELECT product_name FROM top_10_product)
    GROUP BY product_name
)

SELECT 
    a.product_name AS product_a,
    b.product_name AS product_b,
    COUNT(*) AS frequency,
    total,
    ROUND(COUNT(*) * 1.0 / total, 4) AS support,
    ROUND(COUNT(*) * 1.0 / pf_a.freq, 4) AS confidence_a_to_b
FROM analytical_dataset a
JOIN analytical_dataset b ON a.order_id = b.order_id
CROSS JOIN total_orders
JOIN product_freq pf_a ON a.product_name = pf_a.product_name
WHERE a.product_name IN (SELECT product_name FROM top_10_product)
    AND b.product_name IN (SELECT product_name FROM top_10_product)
    AND a.product_name < b.product_name
GROUP BY product_a, product_b, total, pf_a.freq
ORDER BY frequency DESC;

--LIFT--
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
),
product_freq AS (
    SELECT product_name, COUNT(DISTINCT order_id) AS freq
    FROM analytical_dataset
    WHERE product_name IN (SELECT product_name FROM top_10_product)
    GROUP BY product_name
)

SELECT 
    a.product_name AS product_a,
    b.product_name AS product_b,
    COUNT(*) AS frequency,
    ROUND(COUNT(*) * 1.0 / total, 4) AS support,
    ROUND(COUNT(*) * 1.0 / pf_a.freq, 4) AS confidence_a_to_b,
    ROUND(
        (COUNT(*) * 1.0 / pf_a.freq) / (pf_b.freq * 1.0 / total), 4
    ) AS lift
FROM analytical_dataset a
JOIN analytical_dataset b ON a.order_id = b.order_id
CROSS JOIN total_orders
JOIN product_freq pf_a ON a.product_name = pf_a.product_name
JOIN product_freq pf_b ON b.product_name = pf_b.product_name
WHERE a.product_name IN (SELECT product_name FROM top_10_product)
    AND b.product_name IN (SELECT product_name FROM top_10_product)
    AND a.product_name < b.product_name
GROUP BY product_a, product_b, total, pf_a.freq, pf_b.freq
ORDER BY lift DESC;