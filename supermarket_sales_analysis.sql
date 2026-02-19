/*
Project: Supermarket Sales Performance Analysis (SQL Server)
Dataset: sales.csv (1000 transactions)

Goal:
- Analyze overall business KPIs
- Compare performance across cities and branches
- Understand customer loyalty impact (Member vs Normal)
- Identify top categories and products
- Measure revenue concentration risk (Top 3 products %)

Author: Angad Singh
*/


-- OverAll Business KPIs

select
  COUNT(*) as total_transactions,
  CAST(SUM(total_price) as decimal(12,2)) as total_revenue,
  SUM(quantity) as total_units_sold,
  CAST(AVG(total_price) as decimal(10,2)) as avg_bill_value,
  CAST(AVG(CAST(quantity as float)) as decimal(10,2)) as avg_items_per_bill
from Sales;


-- City Performance KPIs

select
  city,
  COUNT(*) as transactions,
  CAST(SUM(total_price) as decimal(12,2)) as revenue,
  CAST(AVG(total_price) as decimal (12, 2)) as avg_bill_value
from Sales
group by city
order by revenue DESC;


--Category KPIs

select
  product_category,
  COUNT(*) as transactions,
  SUM(quantity) as units_sold,
  CAST(SUM(total_price) as decimal(12,2)) as revenue,
  CAST(AVG(total_price) as decimal(10,2)) as avg_bill_value
from Sales
group by product_category
order by revenue DESC;

-- Top-Selling Products: Top 3 Products contributing the most to sales

select top 3
	product_name,
	CAST(sum(total_price) as decimal(12,2)) total_sales
from sales
group by product_name
order by total_sales desc


-- Which branch generates the highest revenue?

select 
	branch,
	COUNT(*) as transactions,
	CAST(SUM(total_price) as decimal(12,2)) as revenue,
	CAST(AVG(total_price) as decimal(10,2)) as avg_bill_value,
    CAST(100.0 * SUM(total_price) / (select SUM(total_price) from Sales) as decimal(6,2)) as revenue_pct

from sales
group by branch


-- Which city has the highest average bill value?

select top 1
  city,
  CAST(AVG(total_price) as decimal(10,2)) as avg_bill_value
from dbo.Sales
group by city
order by avg_bill_value DESC;


-- Member vs Normal — who contributes more revenue?

select
  customer_type,
  COUNT(*) as transactions,
  CAST(SUM(total_price) as decimal(12,2)) as revenue,
  CAST(AVG(total_price) as decimal(10,2)) as avg_bill_value
from dbo.Sales
group by customer_type
order by revenue DESC;


-- Top category per city

WITH cat_city as (
  select
    city,
    product_category,
    SUM(total_price) as revenue,
    ROW_NUMBER() OVER (PARTITION BY city order by SUM(total_price) DESC) as rn
  from dbo.Sales
  group by city, product_category
)
select
  city,
  product_category,
  CAST(revenue as decimal(12,2)) as revenue
from cat_city
WHERE rn = 1
order by revenue DESC;

-- Revenue concentration risk

WITH prod as (
    select product_name, SUM(total_price) as revenue
    from Sales
    group by product_name
),
top3 as (
    select TOP 3 * from prod order by revenue DESC
)
select
    CAST(SUM(revenue) as decimal(12,2)) as top3_revenue,
    CAST(100.0 * SUM(revenue) / (select SUM(total_price) from Sales) as decimal(6,2)) as top3_revenue_pct
from top3;



---- INSIGHTS

-- 1) Branch A contributes ~70% of total revenue (₹82,811.64 out of ₹118,583.90), so overall performance is highly dependent on Branch A.
-- 2) New York leads in transaction volume, but Chicago leads in revenue due to higher average bill value—suggesting Chicago customers purchase higher-value baskets.
-- 3) Fruits sells the most units (2,286) but Personal Care generates the most revenue (₹27,050.18), indicating Personal Care items are higher value per unit.
-- 4) Each city has a different top category, so promotions should be localized instead of one-size-fits-all.
-- 5) Members contribute higher revenue (₹63,213.63 vs ₹55,370.27) and maintain a competitive average bill value, indicating loyalty customers are financially valuable.
-- 6) Top 3 products contribute 64.53% of total revenue (₹76,520.80 out of ₹118,583.90), indicating moderate-to-high revenue concentration.
--    Ensuring stock availability and targeted promotions for these products is critical to maintaining overall revenue stability.
