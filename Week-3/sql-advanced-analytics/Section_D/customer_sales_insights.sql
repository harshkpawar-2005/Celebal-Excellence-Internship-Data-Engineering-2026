-- =========================================
-- Week 3 - Advanced SQL Analytics
-- Section D - Customer Sales Insights
-- =========================================

USE superstore_db;

-- =========================================
-- Q1. Top 10 Customers
-- =========================================

WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
    FROM superstore_raw
    GROUP BY customer_id, customer_name
)

SELECT *
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================
-- Q2. Bottom 10 Customers
-- =========================================

WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
    FROM superstore_raw
    GROUP BY customer_id, customer_name
)

SELECT *
FROM customer_sales
ORDER BY total_sales ASC
LIMIT 10;


-- =========================================
-- Q3. Single Order Customers
-- =========================================

SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_raw
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT order_id) = 1;


-- =========================================
-- Q4. Customer Sales Ranking
-- =========================================

WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
    FROM superstore_raw
    GROUP BY customer_id, customer_name
)

SELECT
    customer_id,
    customer_name,
    total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM customer_sales;


-- =========================================
-- Q5. Above Average Customers
-- =========================================

WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
    FROM superstore_raw
    GROUP BY customer_id, customer_name
)

SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
)
ORDER BY total_sales DESC;


-- =========================================
-- Validation
-- =========================================

SELECT COUNT(*) AS total_rows
FROM superstore_raw;