-- Customer lifetime value analysis

SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value),2) AS customer_lifetime_value,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY customer_lifetime_value DESC
LIMIT 10;
/*
Business Findings:

1. Highest customer lifetime value observed: 13,664.08.
2. Highest-spending customer placed only one order.
3. Order frequency does not necessarily correlate with revenue.
4. Most top-revenue customers placed between 1 and 3 orders.
5. Customer segmentation should consider both order frequency and spending.

Potential Business Actions:

- Create VIP customer segments based on revenue.
- Develop separate retention strategies for repeat buyers and high-value customers.
- Investigate purchasing patterns of top-spending customers.
*/

-- Customer Segmentation 

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(p.payment_value) AS total_revenue
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_revenue < 100 THEN 'Low Value'
        WHEN total_revenue < 500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_revenue),2) AS avg_revenue
FROM customer_revenue
GROUP BY customer_segment;

/*
Customer Segmentation Findings

Low Value:
- 44,390 customers
- Average Revenue: 60.38
- Total Revenue: 2.68M

Medium Value:
- 47,216 customers
- Average Revenue: 193.88
- Total Revenue: 9.15M

High Value:
- 4,489 customers
- Average Revenue: 929.95
- Total Revenue: 4.17M

Key Insights:

1. High-value customers represent approximately 4.7% of the customer base.
2. High-value customers contribute approximately 26% of total revenue.
3. Average spend of high-value customers is over 15x that of low-value customers.
4. Customer retention efforts should prioritize the high-value segment.
*/