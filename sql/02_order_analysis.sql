-- AVERAGE DELIVERY TIME

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;

/*
Business Findings:

1. Average delivery time is 12.50 days.
2. Delivery performance appears stable.
3. Further analysis required to compare
   actual delivery dates against estimated
   delivery dates.
*/

-- ON-TIME DELIVERY PERFORMANCE

SELECT
    ROUND(
        AVG(
            CASE
                WHEN order_delivered_customer_date
                     <= order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS on_time_delivery_rate
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;

/*
Business Findings:

1. On-time delivery rate is 92.13%.
2. Approximately 7.87% of orders were delivered late.
3. Logistics performance appears strong overall.
4. Late deliveries represent a potential opportunity
   for operational improvement and customer experience optimization.
*/

-- ON-TIME DELIVERY RATE BY STATE

SELECT
    c.customer_state,
    ROUND(
        AVG(
            CASE
                WHEN o.order_delivered_customer_date
                     <= o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS on_time_delivery_rate,
    COUNT(*) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(*) >= 100
ORDER BY on_time_delivery_rate ASC;

/*
Business Findings:

1. Delivery performance varies by state.
2. Lowest on-time delivery rates:
   - AL
   - MA
   - PI

3. Highest on-time delivery rates:
   - RO
   - AM
   - PR

4. Geographic factors may influence delivery reliability.
5. Additional investigation recommended into regional logistics operations.

*/