with customers as (
    select * from {{ ref('customers') }}
),
orders as (
    select * from {{ ref('orders') }}
),
order_items as (
    select * from {{ ref('order_items') }}
)

select 
    c.id as customer_id,
    c.name as customer_name,
    sum(oi.quantity * oi.unit_price) as total_spent
from customers c
join orders o on c.id = o.customer_id
join order_items oi on o.id = oi.order_id
group by 1, 2