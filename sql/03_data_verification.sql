-- ===================================================
-- Project: Smart E-Commerce Analytics System
-- Script: 03_data_verification.sql
-- Description: Validate ingested record counts across tables
-- ===================================================

SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments;