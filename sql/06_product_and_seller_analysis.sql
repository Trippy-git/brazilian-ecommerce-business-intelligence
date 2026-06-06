-- Seller Analysis

SELECT
    seller_id,
    ROUND(SUM(price),2) AS total_revenue,
    COUNT(*) AS total_items_sold
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

/*
TOP SELLERS BY REVENUE ANALYSIS
Business Findings:

1. The highest-revenue seller generated 229,472.63 in product revenue.

2. The highest-revenue seller sold 1,156 items, but was NOT the seller with the highest sales volume.

3. A different seller sold 1,987 items while generating 200,472.92 in revenue.

4. Revenue generation is influenced by both:
   - Number of items sold
   - Average selling price

5. High sales volume does not necessarily translate to the highest revenue.

6. Some sellers appear to follow a premium pricing strategy,
   generating more revenue from fewer items sold.

7. Other sellers appear to follow a volume-based strategy,
   selling larger quantities at lower average prices.

Key Insight:

Revenue and sales volume should be analyzed separately.
A seller can generate high revenue through premium-priced products
without being the highest-volume seller.

Business Implications:

- Seller performance should be evaluated using both revenue and volume KPIs.
- High-revenue sellers may require retention and partnership strategies.
- Premium-product sellers and high-volume sellers represent different business models.
- Marketplace dependence on a small number of sellers should be investigated further through revenue concentration analysis.

*/

-- Top 10 Seller Revenue Share 

WITH seller_revenue AS (
    SELECT
        seller_id,
        SUM(price) AS revenue
    FROM olist_order_items_dataset
    GROUP BY seller_id
)

SELECT
    ROUND(
        SUM(revenue) * 100 /
        (
            SELECT SUM(price)
            FROM olist_order_items_dataset
        ),
        2
    ) AS top_10_revenue_percentage
FROM (
    SELECT revenue
    FROM seller_revenue
    ORDER BY revenue DESC
    LIMIT 10
) top_sellers;

/*

TOP 10 SELLER REVENUE CONCENTRATION ANALYSIS


Business Findings:

1. Top 10 sellers contribute 13.15% of total marketplace revenue.

2. Revenue concentration among top sellers is relatively low.

3. The marketplace appears to have a diversified seller ecosystem.

4. No evidence suggests extreme dependency on a small number of sellers.

5. Revenue generation is distributed across a broad seller base.

Key Insight:

The platform demonstrates healthy seller diversification,
reducing operational and revenue risk associated with the loss
of any individual seller.

Business Implications:

- Lower seller concentration risk.
- Greater marketplace resilience.
- Revenue generation is supported by a broad merchant network.

*/