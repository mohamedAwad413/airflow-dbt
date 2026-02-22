
  
    

  create  table "sales_db"."analysis_sales"."customer_order__dbt_tmp"
  
  
    as
  
  (
    

WITH customers AS (
    SELECT * FROM "sales_db"."raw_sales"."customers"
),

orders AS (
    SELECT * FROM "sales_db"."raw_sales"."orders"
)

SELECT 
    o.order_id,
    c.customer_unique_id,
    c.customer_city,
    o.order_status,
    o.order_purchase_timestamp,
    AGE(o.order_delivered_customer_date, o.order_purchase_timestamp) AS delivery_time
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  );
  