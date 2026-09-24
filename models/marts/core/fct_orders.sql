with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

order_item_summary as (
    select * from {{ ref('int_order_items_summed') }}
),

final as (
    select
        orders.order_key,
        orders.customer_key,
        orders.order_status,
        orders.order_date,
        orders.order_priority,
        orders.clerk_name,
        orders.ship_priority,
        order_item_summary.total_quantity,
        order_item_summary.net_item_sales_amount,
        order_item_summary.line_item_count
    from orders
    left join order_item_summary
        on orders.order_key = order_item_summary.order_key
)

select * from final