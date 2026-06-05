-- REVENUE OVERVIEW

SELECT
    ROUND(SUM(payment_value),2) AS total_revenue,
    ROUND(AVG(payment_value),2) AS avg_order_value,
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment
FROM olist_order_payments_dataset;