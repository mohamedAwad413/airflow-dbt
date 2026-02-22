

WITH orders_combined AS (
    SELECT 
        o.order_id,
        c.customer_city,
        c.customer_state
    FROM "sales_db"."raw_sales"."orders" o
    JOIN "sales_db"."raw_sales"."customers" c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered' 
) 

SELECT 
    customer_city,
    customer_state,
    COUNT(order_id) as total_orders
FROM orders_combined
GROUP BY 1, 2
ORDER BY total_orders DESC