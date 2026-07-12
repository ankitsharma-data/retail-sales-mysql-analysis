USE retail_sales;

-- ============================================================
-- Retail Sales Analysis — SQL Queries
-- Author: Ankit Sharma (MySQL version)
-- Database: retail_sales (customers, products, orders, order_items)
-- ============================================================

-- 1. Total revenue generated
SELECT ROUND(SUM(oi.quantity * p.price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 2. Top 5 best-selling products by quantity sold
SELECT p.product_name, SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 5;

-- 3. Revenue by product category
SELECT p.category, ROUND(SUM(oi.quantity * p.price), 2) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 4. Monthly revenue trend
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       ROUND(SUM(oi.quantity * p.price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- 5. Top 5 customers by total spend
SELECT c.customer_id, c.customer_name, ROUND(SUM(oi.quantity * p.price), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- 6. Number of orders per city
SELECT c.city, COUNT(DISTINCT o.order_id) AS num_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY num_orders DESC;

-- 7. Average order value (AOV)
SELECT ROUND(SUM(oi.quantity * p.price) * 1.0 / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 8. Customers who have never placed an order (no purchase yet)
SELECT c.customer_name, c.city
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 9. Repeat customers (placed more than 1 order)
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

-- 10. Products that generated below-average revenue (using a subquery)
SELECT p.product_name, ROUND(SUM(oi.quantity * p.price), 2) AS product_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
CROSS JOIN (
    SELECT AVG(rev) AS avg_rev FROM (
        SELECT SUM(oi2.quantity * p2.price) AS rev
        FROM order_items oi2
        JOIN products p2 ON oi2.product_id = p2.product_id
        GROUP BY p2.product_id
    ) AS product_totals
) AS avg_table
GROUP BY p.product_name, avg_table.avg_rev
HAVING product_revenue < avg_table.avg_rev
ORDER BY product_revenue ASC;
