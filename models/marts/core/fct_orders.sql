with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments')}}

),

customer_payments as (

    select
        customer_id,
        order_id,

        sum(amount) as amount

    from payments

    group by customer_id,
             order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        coalesce(customer_payments.amount, 0) as amount

    from orders

    left join customer_payments using (customer_id)

)

select * from final
