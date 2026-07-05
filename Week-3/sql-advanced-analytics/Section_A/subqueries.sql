-- =========================================
-- Week 3 - Advanced SQL Analytics
-- Section A - Subqueries
-- =========================================

USE superstore_db;


-- =========================================
-- Q1. Orders with Sales Above Average
-- =========================================

SELECT
    order_id,
    customer_id,
    CAST(sales AS DECIMAL(10,2)) AS sales
FROM superstore_raw
WHERE CAST(sales AS DECIMAL(10,2)) >
(
    SELECT AVG(CAST(sales AS DECIMAL(10,2)))
    FROM superstore_raw
)
ORDER BY sales DESC;

-- =========================================
-- Q2. Highest Sales Order
-- =========================================

SELECT
    order_id,
    customer_id,
    product_name,
    CAST(sales AS DECIMAL(10,2)) AS sales
FROM superstore_raw
WHERE CAST(sales AS DECIMAL(10,2)) =
(
    SELECT MAX(CAST(sales AS DECIMAL(10,2)))
    FROM superstore_raw
);

-- =========================================
-- Q3. Products with Above Average Profit
-- =========================================

SELECT
    product_name,
    CAST(profit AS DECIMAL(10,2)) AS profit
FROM superstore_raw
WHERE CAST(profit AS DECIMAL(10,2)) >
(
    SELECT AVG(CAST(profit AS DECIMAL(10,2)))
    FROM superstore_raw
)
ORDER BY profit DESC;


-- =========================================
-- Q4. Customers with Above Average Total Sales
-- =========================================

SELECT
    customer_id,
    customer_name,
    SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
FROM superstore_raw
GROUP BY customer_id, customer_name
HAVING total_sales >
(
    SELECT AVG(customer_sales)
    FROM
    (
        SELECT
            SUM(CAST(sales AS DECIMAL(10,2))) AS customer_sales
        FROM superstore_raw
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_sales DESC;

-- =========================================
-- Q5. Products with Sales Above Average
-- =========================================

SELECT
    product_name,
    CAST(sales AS DECIMAL(10,2)) AS sales
FROM superstore_raw
WHERE CAST(sales AS DECIMAL(10,2)) >
(
    SELECT AVG(CAST(sales AS DECIMAL(10,2)))
    FROM superstore_raw
)
ORDER BY sales DESC;


-- =========================================
-- Validation
-- =========================================

SELECT COUNT(*) AS total_rows
FROM superstore_raw;