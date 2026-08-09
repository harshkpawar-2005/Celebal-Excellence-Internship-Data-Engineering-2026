WITH customer_orders AS (
    SELECT DISTINCT
        o.customer_id,
        date(o.order_date) AS order_date
    FROM orders o
    WHERE o.customer_id != -1
),

customer_cohorts AS (
    SELECT
        c.customer_id,
        strftime('%Y-%m', c.registration_date) AS cohort_month
    FROM customers c
),

order_months AS (
    SELECT
        co.customer_id,
        co.cohort_month,
        (
            (CAST(strftime('%Y', co2.order_date) AS INTEGER) -
             CAST(substr(co.cohort_month, 1, 4) AS INTEGER)) * 12
            +
            (CAST(strftime('%m', co2.order_date) AS INTEGER) -
             CAST(substr(co.cohort_month, 6, 2) AS INTEGER))
        ) AS month_number
    FROM customer_cohorts co
    JOIN customer_orders co2
        ON co.customer_id = co2.customer_id
),

cohort_counts AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM order_months
    WHERE month_number BETWEEN 0 AND 3
    GROUP BY cohort_month, month_number
)

SELECT
    cohort_month,
    month_number,
    active_customers,
    ROUND(
        active_customers * 100.0 /
        MAX(
            CASE
                WHEN month_number = 0
                THEN active_customers
            END
        ) OVER (
            PARTITION BY cohort_month
        ),
        2
    ) AS retention_rate
FROM cohort_counts
ORDER BY cohort_month, month_number;