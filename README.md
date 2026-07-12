![Project Cover](images/cover.png)

# 🛍️ Retail Sales Analysis using MySQL

## 📌 Project Overview

This project demonstrates an end-to-end **Retail Sales Analysis** using **MySQL**. It focuses on database design, data analysis, and generating actionable business insights using SQL.

---

## 🛠️ Tech Stack

- MySQL
- SQL
- Git
- GitHub

---

## 📂 Repository Structure

```text
retail-sales-mysql-analysis
│
├── images/
│   └── cover.png
├── 01_schema.sql
├── 02_seed_data.sql
├── 03_analysis_queries.sql
└── README.md
```

---
# Retail Sales Analysis using MySQL

## Overview
A relational database of retail sales (customers, products, orders, and order items) built in MySQL, analyzed using SQL to answer business questions like revenue trends, top products, and customer behavior.

## Database Schema
- **customers** — customer_id, customer_name, city, signup_date
- **products** — product_id, product_name, category, price
- **orders** — order_id, customer_id, order_date
- **order_items** — order_item_id, order_id, product_id, quantity

40 customers, 12 products, 250 orders, 625 order line items.

## Business Questions Answered
1. What is the total revenue generated?
2. Which products sell the most units?
3. Which product category earns the most revenue?
4. How does revenue trend month over month?
5. Who are the top-spending customers?
6. Which cities generate the most orders?
7. What is the average order value?
8. Are there any customers who haven't purchased yet?
9. Which customers are repeat buyers?
10. Which products underperform relative to the average?

## Tools Used
- MySQL
- SQL (joins, GROUP BY, HAVING, subqueries, DATE_FORMAT)

## Files
- `01_schema.sql` — creates the database and tables
- `02_seed_data.sql` — inserts sample data (40 customers, 12 products, 250 orders, 625 order items)
- `03_analysis_queries.sql` — 10 analysis queries

## How to Run (XAMPP / MySQL Workbench)

### Option A: Using phpMyAdmin (XAMPP)
1. Install XAMPP and start Apache + MySQL from the control panel.
2. Open `http://localhost/phpmyadmin` in your browser.
3. Click **Import** → choose `01_schema.sql` → click **Go**.
4. Click **Import** again → choose `02_seed_data.sql` → click **Go**.
5. Click on the `retail_sales` database → **SQL** tab → paste queries from `03_analysis_queries.sql` one at a time and run.

### Option B: Using MySQL Workbench
1. Open MySQL Workbench and connect to your local MySQL server.
2. Open `01_schema.sql` → click the lightning bolt icon (Execute) to run the whole script.
3. Open `02_seed_data.sql` → Execute.
4. Open `03_analysis_queries.sql` → run each query (select it, then Ctrl+Enter) to see results.

### Option C: Command line
```bash
mysql -u root -p < 01_schema.sql
mysql -u root -p < 02_seed_data.sql
mysql -u root -p retail_sales < 03_analysis_queries.sql
```

## Key Findings
- Total revenue across all orders: **₹16,83,401**
- **Electronics** is the highest-revenue category (~60% of total revenue)
- Average order value: **₹6,733.6**
- Top customer by spend: Ankit Verma (customer_id 32), with ₹85,577 total spend
- Most frequent repeat buyer: Aman Mishra (customer_id 27), with 12 separate orders
- Stationery items (e.g. Notebook Set) consistently underperform other categories

## Note
Customer names in the sample data are not unique (multiple different customers share the same name, as happens in real systems). Queries that report per-customer results group by `customer_id` (not name) to keep each customer's numbers accurate.

This project was originally prototyped in SQLite for query development, then converted to standard MySQL syntax (AUTO_INCREMENT, InnoDB engine, DATE_FORMAT). Verified by executing all scripts against a MySQL 8 instance.
