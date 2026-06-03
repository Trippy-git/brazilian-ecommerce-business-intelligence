-- Ecommerce Analytics Project
-- Database Setup

CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

-- Imported customers dataset
-- Verified sucessful 

-- Verified customer table structure

DESCRIBE olist_customers_dataset;

-- Previewed customer data

SELECT *
FROM olist_customers_dataset
LIMIT 10;

-- Counted total customers

SELECT COUNT(*) AS total_customers
FROM olist_customers_dataset;

-- Customer distribution by state

SELECT customer_state,
       COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC;

--Orders by customer state 

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;


-- ORDER STATUS ANALYSIS


SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM olist_orders_dataset),
        2
    ) AS percentage
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

/*
Business Findings:

1. Delivered orders account for 97.02% of total orders.
2. Cancellation rate is 0.63%.
3. Unavailable orders account for 0.61%.
4. Order fulfillment performance appears highly efficient.
5. Further investigation required to determine whether
   unavailable products contribute to cancellations.

*/
