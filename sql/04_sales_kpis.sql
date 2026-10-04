-- ===================================================
-- Project: Smart E-Commerce Analytics System
-- Script: 04_sales_kpis.sql
-- Description: Core revenue and sales volume KPIs
-- ===================================================

-- 1. Baseline Store Performance (Total Orders, Total Revenue, Average Order Value)
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(price), 2) AS average_order_value,
    ROUND(SUM(freight_value), 2) AS total_shipping_revenue
FROM order_items;


-- 2. Monthly Revenue and Order Volume Trends
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS sales_month,
    COUNT(DISTINCT o.order_id) AS monthly_orders,
    ROUND(SUM(oi.price), 2) AS monthly_revenue,
    ROUND(AVG(oi.price), 2) AS monthly_aov
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY sales_month ASC;


-- 3. Payment Method Distribution and Share
SELECT 
    payment_type,
    COUNT(order_id) AS transaction_count,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS avg_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- 4. Top 10 Customer States by Revenue
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;