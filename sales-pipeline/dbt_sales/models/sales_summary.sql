WITH source_data AS (
    SELECT 
        oi.id AS item_id,
        oi.order_id,
        oi.product_id,
        oi.quantity,
        oi.unit_price,
        p.name AS product_name,
        p.category
    FROM {{ ref('order_items') }} AS oi
    JOIN {{ ref('products') }} AS p ON oi.product_id = p.id
)

SELECT 
    product_name,
    category,
    SUM(quantity) as total_qty,
    SUM(quantity * unit_price) as total_revenue
FROM source_data
GROUP BY 1, 2