-- Q1: Revenue by category

SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ),
        2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- Q2: Top 10 customers

SELECT
    o.customer_id,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ),
        2
    ) AS total_order_value
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.order_id
WHERE o.customer_id != -1
GROUP BY o.customer_id
ORDER BY total_order_value DESC
LIMIT 10;


-- Q3: Month-wise order count

SELECT
    strftime('%Y-%m', order_date) AS order_month,
    COUNT(DISTINCT order_id) AS order_count
FROM orders
WHERE date(order_date) >= date(
    (SELECT MAX(order_date) FROM orders),
    '-12 months'
)
GROUP BY order_month
ORDER BY order_month;