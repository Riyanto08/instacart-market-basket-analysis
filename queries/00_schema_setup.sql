--CREATE TABLE--
CREATE TABLE aisles (
 aisle_id INT PRIMARY KEY,
 aisle VARCHAR
);

CREATE TABLE departments (
 department_id INT PRIMARY KEY,
 department VARCHAR
);

CREATE TABLE products (
 product_id INT PRIMARY KEY,
 product_name VARCHAR,
 aisle_id INT,
 department_id INT
);


CREATE TABLE orders (
 order_id INT PRIMARY KEY,
 user_id INT,
 eval_set VARCHAR,
 order_number INT,
 order_dow INT,
 order_hour_of_day INT,
 days_since_prior_order FLOAT
);

CREATE TABLE order_products_prior ( 
  order_id INT, 
  product_id INT,
  add_to_cart_order INT, 
  reordered BOOLEAN, 
  PRIMARY KEY (order_id, product_id)
);

CREATE TABLE order_products_train ( 
  order_id INT, 
  product_id INT,
  add_to_cart_order INT, 
  reordered BOOLEAN, 
  PRIMARY KEY (order_id, product_id)
);

--IMPORT DATA--
COPY aisles
FROM 'D:\Dataset\Instacart Market Basket Analysis\aisles.csv'
DELIMITER ','
CSV HEADER;

COPY departments
FROM 'D:\Dataset\Instacart Market Basket Analysis\departments.csv'
DELIMITER ','
CSV HEADER;

COPY products
FROM 'D:\Dataset\Instacart Market Basket Analysis\products.csv'
DELIMITER ','
CSV HEADER;

COPY orders
FROM 'D:\Dataset\Instacart Market Basket Analysis\orders.csv'
DELIMITER ','
CSV HEADER;

COPY order_products_prior
FROM 'D:\Dataset\Instacart Market Basket Analysis\order_products__prior.csv'
DELIMITER ','
CSV HEADER;

COPY order_products_train
FROM 'D:\Dataset\Instacart Market Basket Analysis\order_products__train.csv'
DELIMITER ','
CSV HEADER;