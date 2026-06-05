-- REVENUE OVERVIEW

SELECT
    ROUND(SUM(payment_value),2) AS total_revenue,
    ROUND(AVG(payment_value),2) AS avg_order_value,
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment
FROM olist_order_payments_dataset;

/*
Business Findings:

1. Total platform revenue exceeds 16 million.
2. Average order value is 154.10.
3. Zero-value payments exist and require investigation.
4. Maximum payment value is 13,664.08.
5. Revenue distribution is likely right-skewed.
*/