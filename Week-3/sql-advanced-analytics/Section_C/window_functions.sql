-- =========================================
-- Week 3 - Advanced SQL Analytics
-- Section C - Window Functions
-- =========================================

USE superstore_db;

-- =========================================
-- Q1. ROW_NUMBER()
-- =========================================

SELECT
    customer_id,
    customer_name,
    SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales,
    ROW_NUMBER() OVER(
        ORDER BY SUM(CAST(sales AS DECIMAL(10,2))) DESC
    ) AS row_num
FROM superstore_raw
GROUP BY customer_id, customer_name;


-- =========================================
-- Q2. RANK()
-- =========================================

SELECT
    customer_id,
    customer_name,
    SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(CAST(sales AS DECIMAL(10,2))) DESC
    ) AS sales_rank
FROM superstore_raw
GROUP BY customer_id, customer_name;



-- =========================================
-- Q3. DENSE_RANK()
-- =========================================

SELECT
    customer_id,
    customer_name,
    SUM(CAST(sales AS DECIMAL(10,2))) AS total_sales,
    DENSE_RANK() OVER(
        ORDER BY SUM(CAST(sales AS DECIMAL(10,2))) DESC
    ) AS sales_dense_rank
FROM superstore_raw
GROUP BY customer_id, customer_name;


-- =========================================
-- Q4. ROW_NUMBER() with PARTITION BY
-- =========================================

SELECT
    category,
    product_name,
    CAST(sales AS DECIMAL(10,2)) AS sales,
    ROW_NUMBER() OVER(
        PARTITION BY category
        ORDER BY CAST(sales AS DECIMAL(10,2)) DESC
    ) AS category_rank
FROM superstore_raw;


-- =========================================
-- Q5. Top Product in Each Category
-- =========================================

SELECT *
FROM
(
    SELECT
        category,
        product_name,
        CAST(sales AS DECIMAL(10,2)) AS sales,
        ROW_NUMBER() OVER(
            PARTITION BY category
            ORDER BY CAST(sales AS DECIMAL(10,2)) DESC
        ) AS rn
    FROM superstore_raw
) ranked_products
WHERE rn = 1;


-- =========================================
-- Validation
-- =========================================

SELECT COUNT(*) AS total_rows
FROM superstore_raw;

