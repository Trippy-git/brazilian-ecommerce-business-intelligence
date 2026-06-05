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