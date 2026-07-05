-- =========================================
-- Week 3 - Advanced SQL Analytics
-- Create Staging Table
-- =========================================

USE superstore_db;

CREATE TABLE superstore_raw (
    row_id VARCHAR(20),
    order_id VARCHAR(30),
    order_date VARCHAR(30),
    ship_date VARCHAR(30),
    ship_mode VARCHAR(50),

    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(50),

    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),

    product_id VARCHAR(30),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),

    sales VARCHAR(30),
    quantity VARCHAR(20),
    discount VARCHAR(20),
    profit VARCHAR(30)
);

-- =========================================
-- Validation Queries
-- =========================================

SELECT COUNT(*) AS total_rows
FROM superstore_raw;

SELECT *
FROM superstore_raw
WHERE order_id IS NULL
   OR order_id = '';
   
SELECT *
FROM superstore_raw
WHERE customer_id IS NULL
   OR customer_id = '';