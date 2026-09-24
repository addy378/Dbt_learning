with line_items as (
    select * from {{ ref('stg_tpch__lineitem') }}
),

aggregated as (
    select
        order_key,
        sum(quantity)                                                   as total_quantity,
        sum({{ calculate_net_item_sales('extended_price', 'discount_percentage') }}) as net_item_sales_amount,
        count(distinct line_number)                                     as line_item_count
    from line_items
    group by order_key
)

select * from aggregated