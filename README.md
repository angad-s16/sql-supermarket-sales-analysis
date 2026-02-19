# 🛒 Supermarket Sales Performance Analysis (SQL Server)

## 📌 Project Overview
This project analyzes transactional sales data from a supermarket chain operating across multiple cities and branches.

**Objective:** Identify revenue drivers across locations, customer segments, and product mix, and highlight concentration risk from top products.

All analysis was performed using **SQL Server (T-SQL)**.

---

## 🗂 Dataset
The dataset contains **1,000 transactions** with the following columns:

- sale_id (transaction id)
- city, branch
- customer_type (Member / Normal), gender
- product_name, product_category
- unit_price, quantity, tax, total_price, reward_points

---

## 📊 Key KPIs (Overall)
- **Total Transactions:** 1,000  
- **Total Revenue:** ₹118,583.90  
- **Total Units Sold:** 10,341  
- **Average Bill Value:** ₹118.58  
- **Average Items per Bill:** 10.34  

---

## 🧠 Business Questions Answered
1. What are the overall business KPIs (revenue, transactions, units, avg bill, avg items)?
2. Which city generates the highest revenue?
3. Which city has the highest average bill value?
4. Which product category generates the most revenue?
5. Which products contribute the most to sales (Top 3)?
6. Which branch generates the highest revenue and what is its revenue share?
7. Do Members contribute more revenue than Normal customers?
8. What is the top category in each city?
9. What percentage of revenue comes from the Top 3 products (concentration risk)?

---

## ✅ Key Insights
- **Branch A contributes ~70% of total revenue (₹82,811.64 out of ₹118,583.90)**, indicating strong dependence on one branch.
- **New York leads transaction volume**, but **Chicago leads revenue due to the highest average bill value**, suggesting Chicago customers purchase higher-value baskets.
- **Fruits sells the most units (2,286)**, while **Personal Care generates the most revenue (₹27,050.18)**, indicating Personal Care products are higher value per unit.
- **Each city has a different top category**, supporting localized promotions rather than one-size-fits-all strategy.
- **Members generate higher revenue (₹63,213.63 vs ₹55,370.27)**, reinforcing the financial value of loyalty customers.
- **Top 3 products contribute 64.53% of total revenue**, indicating moderate-to-high revenue concentration—inventory availability for these products is critical.

---

## 🛠 SQL Concepts Used
- Aggregations: SUM, AVG, COUNT
- GROUP BY + ORDER BY
- Window Functions: ROW_NUMBER()
- CTEs
- Subqueries
- Revenue share calculations

---

## ▶️ How to Run
1. Import `sales.csv` into SQL Server as a table named `Sales`
2. Run `supermarket_sales_analysis.sql` in SSMS

---

## 📁 Files in this Repository
- `sales.csv` → Dataset  
- `supermarket_sales_analysis.sql` → Full SQL analysis + KPIs + insights  
