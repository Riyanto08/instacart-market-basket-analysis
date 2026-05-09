--DATA PREPARATION--

CREATE TABLE analytical_dataset AS
SELECT 
    op.order_id,
    op.product_id,
    op.reordered,
    o.user_id,
    o.order_dow,
    o.order_hour_of_day,
    p.product_name,
    a.aisle,
    d.department
FROM order_products_prior op
JOIN orders o ON op.order_id=o.order_id
JOIN products p ON op.product_id=p.product_id
JOIN aisles a ON p.aisle_id=a.aisle_id
JOIN departments d ON p.department_id=d.department_id

SELECT COUNT(*) FROM analytical_dataset;

SELECT * FROM analytical_dataset LIMIT 10;
