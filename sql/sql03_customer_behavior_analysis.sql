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

-- TOP REPEAT CUSTOMERS

SELECT
    c.customer_unique_id,
    COUNT(*) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;

/*
Business Findings:

1. Most customers place only one order.
2. A small subset of customers exhibits strong repeat-purchase behavior.
3. The highest-frequency customer placed 17 orders.
4. Several customers placed between 6 and 9 orders.
5. These customers may represent loyal or high-value customer segments.

Potential Business Actions:

- Identify characteristics of repeat customers.
- Develop retention strategies based on high-engagement behavior.
- Evaluate contribution of repeat customers to revenue.
*/