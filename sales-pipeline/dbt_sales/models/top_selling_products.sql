with orders_detail as (
    select 
        oi.product_id,
        p.name as product_name,
        oi.quantity,
        oi.unit_price
    from {{ ref('order_items') }} oi 
    join {{ ref('products') }} p on oi.product_id = p.id
)

select 
    product_name,
    sum(quantity) as total_quantity,
    sum(quantity * unit_price) as total_revenue
from orders_detail
group by product_name
order by total_revenue desc