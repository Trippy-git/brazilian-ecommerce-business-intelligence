--Customer Behavior & Retention Analysis

WITH order_count AS (
    SELECT
        c.customer_unique_id,
        COUNT(*) AS total_orders
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    total_orders,
    COUNT(customer_unique_id) AS total_customers
FROM order_count
GROUP BY total_orders
ORDER BY total_orders;

/*
Business Findings:

1. Approximately 97% of customers placed only one order.
2. Repeat customer rate is approximately 3.1%.
3. Customer retention appears relatively low.
4. A small cohort of customers demonstrates repeat purchasing behavior.
5. One customer placed 17 orders, representing a significant outlier.

Potential Business Actions:

- Investigate repeat-customer characteristics.
- Explore retention and loyalty strategies.
- Analyze high-value repeat customers separately.
*/