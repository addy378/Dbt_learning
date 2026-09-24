{% macro calculate_net_item_sales(extended_price_column, discount_column) %}
    ({{ extended_price_column }} * (1 - {{ discount_column }}))
{% endmacro %}