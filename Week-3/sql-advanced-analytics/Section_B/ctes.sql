-- =========================================
-- Week 3 - Advanced SQL Analytics
-- Section B - Common Table Expressions (CTEs)
-- =========================================

USE superstore_db;

-- =========================================
-- Q1. Customer Total Sales
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
ORDER BY total_sales DESC;

-- =========================================
-- Q2. Top 10 Customers
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
-- Q3. Above Average Customers
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
-- Q4. Category Sales
-- =========================================

WITH category_sales AS
(
    SELECT
        category,
        SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
    FROM superstore_raw
    GROUP BY category
)

SELECT *
FROM category_sales
ORDER BY total_sales DESC;

-- =========================================
-- Q5. Region-wise Sales
-- =========================================

WITH region_sales AS
(
    SELECT
        region,
        SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales
    FROM superstore_raw
    GROUP BY region
)

SELECT *
FROM region_sales
ORDER BY total_sales DESC;


-- =========================================
-- Validation
-- =========================================

SELECT COUNT(*) AS total_rows
FROM superstore_raw;