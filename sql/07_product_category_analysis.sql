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

-- Average Selling Price By category

SELECT
    t.product_category_name_english,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price),2) AS total_revenue,
    ROUND(AVG(oi.price),2) AS avg_item_price
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
HAVING COUNT(*) >= 1000
ORDER BY avg_item_price DESC
LIMIT 10;

/*
Business Findings:

1. Computers have the highest average selling price
   among analyzed categories at 1,098.34 per item.

2. Watches & Gifts generates strong revenue through
   high sales volume rather than premium pricing.

3. Product categories exhibit different business models:

   - Premium Categories:
     * Computers
     * Home Appliances
     * Musical Instruments

   - Mass Market Categories:
     * Watches & Gifts
     * Bed Bath Table
     * Health & Beauty

4. Revenue growth can be driven through:
   - Higher transaction volume
   - Higher average selling prices

Key Insights:

- High revenue does not always require high sales volume.
- Premium categories generate significant value per transaction.
- Mass-market categories rely on large sales volumes.
*/

--Top 10 Product Category Revenue concentration

WITH category_revenue AS (
    SELECT
        t.product_category_name_english,
        SUM(oi.price) AS revenue
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
    GROUP BY t.product_category_name_english
)

SELECT
    ROUND(
        SUM(revenue) * 100 /
        (
            SELECT SUM(price)
            FROM olist_order_items_dataset
        ),
        2
    ) AS top_10_category_revenue_share
FROM (
    SELECT revenue
    FROM category_revenue
    ORDER BY revenue DESC
    LIMIT 10
) top_categories;

/* 
Business Findings:

1. The Top 10 product categories contribute 62.36% of total marketplace revenue.

2. Revenue is heavily concentrated among a relatively small number of product categories.

3. Unlike seller revenue, which is well distributed, product category revenue shows significant concentration.

Key Insights:

- Customer demand is focused on a limited set of product categories.
- Inventory planning and marketing investments should prioritize these high-performing categories.
- Diversifying category revenue may reduce dependence on a small number of product segments.

Business Implications:

- Prioritize inventory availability for top-performing categories.
- Allocate marketing budgets toward high-revenue categories.
- Monitor category-level demand trends to mitigate revenue concentration risk.

*/
