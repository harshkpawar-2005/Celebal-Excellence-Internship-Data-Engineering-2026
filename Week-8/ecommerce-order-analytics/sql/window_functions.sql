-- Q7: Running revenue by region

WITH daily_sales AS (
    SELECT
        o.region_code,
        date(o.order_date) AS order_date,
        ROUND(
            SUM(
                oi.quantity *
                oi.unit_price *
                (1 - oi.discount_percent / 100.0)
            ),
            2
        ) AS daily_revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.region_code,
        date(o.order_date)
)

SELECT
    region_code,
    order_date,
    daily_revenue,
    ROUND(
        SUM(daily_revenue) OVER (
            PARTITION BY region_code
            ORDER BY order_date
            ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
        ),
        2
    ) AS running_total
FROM daily_sales
ORDER BY region_code, order_date;


-- Q8: Product ranking within category

WITH product_sales AS (
    SELECT
        p.category,
        p.product_name,
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
    GROUP BY
        p.category,
        p.product_id,
        p.product_name
)

SELECT
    category,
    product_name,
    total_revenue,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS rank_in_category
FROM product_sales
ORDER BY category, rank_in_category;


-- Q9: Customer order gap

WITH customer_orders AS (
    SELECT DISTINCT
        customer_id,
        date(order_date) AS order_date
    FROM orders
    WHERE customer_id != -1
),

with_previous AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date
    FROM customer_orders
),

gaps AS (
    SELECT
        customer_id,
        order_date,
        previous_order_date,
        julianday(order_date) -
        julianday(previous_order_date) AS days_gap
    FROM with_previous
)

SELECT
    customer_id,
    order_date,
    previous_order_date,
    days_gap,
    CASE
        WHEN AVG(days_gap) OVER (
            PARTITION BY customer_id
        ) > 30
        THEN 'At Risk'
        ELSE 'Active'
    END AS customer_status
FROM gaps
ORDER BY customer_id, order_date;