Create Database Supermarketsales

USE SupermarketSales;
GO

-- 1) Row count
SELECT COUNT(*) AS total_rows FROM dbo.Sales;

-- 2) Null checks (core columns)
SELECT
  SUM(CASE WHEN sale_id IS NULL THEN 1 ELSE 0 END) AS null_sale_id,
  SUM(CASE WHEN branch IS NULL THEN 1 ELSE 0 END) AS null_branch,
  SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city,
  SUM(CASE WHEN customer_type IS NULL THEN 1 ELSE 0 END) AS null_customer_type,
  SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS null_product_category,
  SUM(CASE WHEN total_price IS NULL THEN 1 ELSE 0 END) AS null_total_price
FROM dbo.Sales;

-- 3) Duplicate transaction IDs
SELECT sale_id, COUNT(*) AS cnt
FROM dbo.Sales
GROUP BY sale_id
HAVING COUNT(*) > 1;

-- 4) Basic ranges (catch weird values)
SELECT
  MIN(unit_price) AS min_unit_price,
  MAX(unit_price) AS max_unit_price,
  MIN(quantity) AS min_qty,
  MAX(quantity) AS max_qty,
  MIN(total_price) AS min_total,
  MAX(total_price) AS max_total
FROM dbo.Sales;
