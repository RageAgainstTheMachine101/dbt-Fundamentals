-- ClickHouse defalt date value is '1970-01-01', not null, so:
select
    min(order_date) as order_date_min

from {{ ref( 'stg_orders' ) }}
group by order_id
having order_date_min = '1970-01-01'
