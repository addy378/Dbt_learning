{% snapshot customers_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_key',
        strategy='check',
        check_cols=['account_balance', 'market_segment', 'address', 'phone'],
    )
}}

select
    c_custkey     as customer_key,
    c_name        as customer_name,
    c_nationkey   as nation_key,
    c_address     as address,
    c_phone       as phone,
    c_acctbal     as account_balance,
    c_mktsegment  as market_segment
from {{ source('tpch', 'customer') }}

{% endsnapshot %}