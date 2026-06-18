{{ config(materialized='view') }}

with orders as (
    select customer_id, order_id from {{ ref('stg_jaffeshop__orders') }}
),
order_amount as (
    select * from {{ ref('stg_stripe__payments') }}
),
final as (
    select
        orders.customer_id,
        orders.order_id,
        order_amount.amount
    from orders
    inner join order_amount using (order_id)
)
select * from final