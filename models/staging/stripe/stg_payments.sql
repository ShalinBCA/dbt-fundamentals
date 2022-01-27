with payments as(

    select 
        id as payment_id,
        orderid as order_id,
        -- paymentmethod,
        paymentmethod as payment_method,
        status,
        -- amount,
        amount / 100 as amount,
        created as created_at
        -- created  
    from 
        raw.stripe.payment
)

select * from payments