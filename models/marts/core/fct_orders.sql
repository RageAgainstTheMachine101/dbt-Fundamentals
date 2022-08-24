-- order_id
-- customer_id
-- amount (hint: this has to come from payments)

orders as (

    select * from {{ ref('stg_orders') }}

),

with payments as (

    select * from {{ ref('stg_payments')}}

),

customer_payments as (

    select
        customer_id,

        sum(amount) as amount

    from payments

    group by 1

),

final as (

    select
        orders.order_id
        orders.customer_id,
        coalesce(customer_payments.amount, 0) as amount

    from orders

    left join customer_payments using (customer_id)

)

select * from final
