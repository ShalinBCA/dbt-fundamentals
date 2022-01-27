with orders as (
    select * from {{ref('stg_orders')}}
),

-- customers as (
--     select * from {{ref('stg_customers')}}
-- ),

payments as (
    select * from {{ref('stg_payments')}}
),

-- final as (
--     select orders.ORDER_ID,customers.customer_id,payments.amount from payments
--     inner join orders using (ORDER_ID)
--     inner join customers using (customer_id)
-- )

order_payments as (
    select 
        order_id,
        (case when status='success' then amount end) as amount
    from 
        payments

),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.amount,0) as amount
    from
        orders
        left join order_payments
            on orders.order_id  = order_payments.order_id

)

select * from final

