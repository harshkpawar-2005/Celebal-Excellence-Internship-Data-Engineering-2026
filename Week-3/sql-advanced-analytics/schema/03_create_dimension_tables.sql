-- =========================================
-- Week 3 - Advanced SQL Analytics
-- Create Dimension Tables
-- =========================================

USE superstore_db;

-- =========================================
-- Drop Existing Tables
-- =========================================

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

-- =========================================
-- Customers Table
-- =========================================

CREATE TABLE customers AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region
FROM superstore_raw;

-- =========================================
-- Orders Table
-- =========================================

CREATE TABLE orders AS
SELECT DISTINCT
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id
FROM superstore_raw;

-- =========================================
-- Products Table
-- =========================================

CREATE TABLE products AS
SELECT DISTINCT
    product_id,
    category,
    sub_category,
    product_name
FROM superstore_raw;

-- =========================================
-- Validation Queries
-- =========================================

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_products
FROM products;

SELECT *
FROM customers
LIMIT 5;

SELECT *
FROM orders
LIMIT 5;

SELECT *
FROM products
LIMIT 5;