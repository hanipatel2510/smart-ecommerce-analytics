-- ===================================================
-- Project: Smart E-Commerce Analytics System
-- Script: 02_data_ingestion.sql
-- Description: Ingest processed CSV files into PostgreSQL tables
-- ===================================================

-- 1. Ingest Customers
COPY customers (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM 'C:/smart-ecommerce-analytics/data/processed/clean_customers.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 2. Ingest Orders
COPY orders (
    order_id, 
    customer_id, 
    order_status, 
    order_purchase_timestamp, 
    order_approved_at, 
    order_delivered_carrier_date, 
    order_delivered_customer_date, 
    order_estimated_delivery_date
)
FROM 'C:/smart-ecommerce-analytics/data/processed/clean_orders.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 3. Ingest Order Items
ALTER TABLE order_items DROP CONSTRAINT IF EXISTS order_items_order_id_fkey;

COPY order_items (
    order_id, 
    order_item_id, 
    product_id, 
    seller_id, 
    shipping_limit_date, 
    price, 
    freight_value
)
FROM 'C:/smart-ecommerce-analytics/data/processed/clean_items.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 4. Ingest Order Payments
ALTER TABLE order_payments DROP CONSTRAINT IF EXISTS order_payments_order_id_fkey;

COPY order_payments (
    order_id, 
    payment_sequential, 
    payment_type, 
    payment_installments, 
    payment_value
)
FROM 'C:/smart-ecommerce-analytics/data/processed/clean_payments.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');