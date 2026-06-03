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