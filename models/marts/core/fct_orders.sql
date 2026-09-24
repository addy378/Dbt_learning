with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

order_item_summary as (
    select * from {{ ref('int_order_items_summed') }}
),

priority_labels as (
    select * from {{ ref('order_priority_labels') }}
),

final as (
    select
        orders.order_key,
        orders.customer_key,
        orders.order_status,
        orders.order_date,
        orders.order_priority,
        priority_labels.priority_label,
        priority_labels.priority_rank,
        orders.clerk_name,
        orders.ship_priority,
        order_item_summary.total_quantity,
        order_item_summary.net_item_sales_amount,
        order_item_summary.line_item_count
    from orders
    left join order_item_summary
        on orders.order_key = order_item_summary.order_key
    left join priority_labels
        on orders.order_priority = priority_labels.order_priority
)

select * from final