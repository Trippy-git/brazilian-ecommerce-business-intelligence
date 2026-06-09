-- Monthly Sales Performance And Seasonality Analysis

SELECT
    MONTH(o.order_purchase_timestamp) AS month,
    MONTHNAME(o.order_purchase_timestamp) AS month_name,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS sales_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS avg_order_value
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status NOT IN ('unavailable', 'cancelled')
GROUP BY
    MONTH(o.order_purchase_timestamp),
    MONTHNAME(o.order_purchase_timestamp)
ORDER BY month;

/*

Business Objective:
Analyze monthly marketplace performance to identify seasonal sales
patterns.

Business Findings:

1. Revenue peaked in May (1.50M), followed by August (1.43M) and July
   (1.39M).

2. Customer demand closely followed the revenue trend. Months with
   higher order volumes consistently generated higher revenue.

3. September recorded the lowest revenue (624.81K) and the fewest
   orders (4,247).

4. Average Order Value remained relatively stable throughout the year,
   indicating that revenue fluctuations were primarily driven by changes
   in order volume.

Key Insights:

- Revenue growth is primarily driven by order volume.
- Customer spending per order remains relatively consistent.
- The marketplace exhibits seasonal demand patterns.

Business Recommendations:

- Increase inventory before peak months.
- Increase marketing during September and October.
- Use historical trends for demand forecasting.

*/