-- Q4: Customers who ordered but never received a delivered item

SELECT DISTINCT
    o.customer_id
FROM orders o
WHERE o.customer_id != -1
  AND EXISTS (
      SELECT 1
      FROM order_items oi
      WHERE oi.order_id = o.order_id
  )
  AND NOT EXISTS (
      SELECT 1
      FROM orders delivered
      JOIN order_items di
          ON di.order_id = delivered.order_id
      WHERE delivered.customer_id = o.customer_id
        AND delivered.status = 'DELIVERED'
  );


-- Q5: Products with more returned quantity than purchased quantity

SELECT
    p.product_id,
    p.product_name,
    SUM(
        CASE
            WHEN oi.quantity < 0
            THEN ABS(oi.quantity)
            ELSE 0
        END
    ) AS returned_units,
    SUM(
        CASE
            WHEN oi.quantity > 0
            THEN oi.quantity
            ELSE 0
        END
    ) AS purchased_units
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING returned_units > purchased_units;


-- Q6: Return rate by category

SELECT
    p.category,
    SUM(
        CASE
            WHEN oi.quantity < 0
            THEN ABS(oi.quantity)
            ELSE 0
        END
    ) * 100.0 /
    NULLIF(SUM(ABS(oi.quantity)), 0) AS return_rate
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY p.category;


-- Q10: Customer value categories by month

WITH monthly_customer_revenue AS (
    SELECT
        o.customer_id,
        strftime('%Y-%m', o.order_date) AS month,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE o.customer_id != -1
    GROUP BY
        o.customer_id,
        month
),

classified AS (
    SELECT
        customer_id,
        month,
        revenue,
        CASE
            WHEN revenue > 10000 THEN 'High'
            WHEN revenue >= 5000 THEN 'Medium'
            ELSE 'Low'
        END AS customer_segment
    FROM monthly_customer_revenue
)

SELECT
    month,
    customer_segment,
    COUNT(*) AS customer_count
FROM classified
GROUP BY month, customer_segment
ORDER BY month, customer_segment;


-- Q11: Customer lifetime value quartiles

WITH customer_value AS (
    SELECT
        o.customer_id,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS total_value
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE o.customer_id != -1
    GROUP BY o.customer_id
),

quartiled AS (
    SELECT
        customer_id,
        ROUND(total_value, 2) AS total_value,
        NTILE(4) OVER (
            ORDER BY total_value DESC
        ) AS quartile
    FROM customer_value
)

SELECT
    customer_id,
    total_value,
    quartile,
    CASE quartile
        WHEN 1 THEN 'Platinum'
        WHEN 2 THEN 'Gold'
        WHEN 3 THEN 'Silver'
        WHEN 4 THEN 'Bronze'
    END AS quartile_label
FROM quartiled
ORDER BY quartile, total_value DESC;


-- Q12: Year-over-year revenue

WITH monthly_revenue AS (
    SELECT
        strftime('%Y', o.order_date) AS year,
        strftime('%m', o.order_date) AS month,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY year, month
)

SELECT
    year,
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        LAG(revenue, 12) OVER (
            ORDER BY year, month
        ),
        2
    ) AS prev_year_revenue,
    CASE
        WHEN LAG(revenue, 12) OVER (
            ORDER BY year, month
        ) IS NULL
        THEN NULL
        ELSE ROUND(
            (
                revenue -
                LAG(revenue, 12) OVER (
                    ORDER BY year, month
                )
            )
            * 100.0 /
            LAG(revenue, 12) OVER (
                ORDER BY year, month
            ),
            2
        )
    END AS yoy_growth_percent
FROM monthly_revenue
ORDER BY year, month;


-- Q13: First and latest category

WITH purchases AS (
    SELECT
        o.customer_id,
        p.category,
        o.order_date,
        FIRST_VALUE(p.category) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
        ) AS first_category,
        FIRST_VALUE(p.category) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date DESC
        ) AS latest_category
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    JOIN products p
        ON p.product_id = oi.product_id
    WHERE o.customer_id != -1
)

SELECT DISTINCT
    customer_id,
    first_category,
    latest_category,
    CASE
        WHEN first_category = latest_category
        THEN 'No'
        ELSE 'Yes'
    END AS category_shift
FROM purchases;


-- Q14: Cumulative revenue contribution

WITH customer_revenue AS (
    SELECT
        o.customer_id,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE o.customer_id != -1
    GROUP BY o.customer_id
),

running AS (
    SELECT
        customer_id,
        ROUND(revenue, 2) AS revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
        ) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM customer_revenue
)

SELECT
    customer_id,
    revenue,
    ROUND(cumulative_revenue, 2) AS cumulative_revenue,
    ROUND(
        cumulative_revenue * 100.0 / total_revenue,
        2
    ) AS cumulative_percent
FROM running
ORDER BY revenue DESC;


-- Q16: Products frequently bought together

SELECT
    p1.product_name AS product_a,
    p2.product_name AS product_b,
    COUNT(DISTINCT oi1.order_id) AS times_bought_together
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
   AND oi1.product_id < oi2.product_id
JOIN products p1
    ON p1.product_id = oi1.product_id
JOIN products p2
    ON p2.product_id = oi2.product_id
GROUP BY
    oi1.product_id,
    oi2.product_id,
    p1.product_name,
    p2.product_name
ORDER BY times_bought_together DESC;