-- Top Product Categories By Revenue

SELECT
    t.product_category_name_english,
    ROUND(SUM(oi.price),2) AS total_revenue,
    COUNT(*) AS total_items_sold
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

/*
-- Business Findings:

1. Health & Beauty is the highest revenue-generating category.
   - Revenue: 1.26M
   - Items Sold: 9,670

2. Bed Bath Table is the highest-volume category.
   - Items Sold: 11,115
   - Revenue: 1.04M

3. Revenue and sales volume show a strong positive relationship across top categories.

4. Health & Beauty products generate higher revenue per item compared to Bed Bath Table products.

5. Certain categories such as Cool Stuff generate substantial revenue despite lower sales volume, suggesting higher average product prices.

Key Insights:

- High-volume categories are not always the highest-revenue categories.
- Product pricing significantly influences category revenue performance.
- Both volume and revenue metrics should be considered when evaluating category success.

*/