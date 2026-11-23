-- Завдання 1. Покупці за країнами
select
  country,
  count(*) as users_count
from `bigquery-public-data.thelook_ecommerce.users`
group by country
order by users_count desc
limit 10;

-- Завдання 2. Виторг за категоріями товарів
select
  p.category,
  count(oi.product_id) as items_sold,
  round(sum(sale_price), 2) as revenue
from `bigquery-public-data.thelook_ecommerce.order_items` as oi
join `bigquery-public-data.thelook_ecommerce.products` as p 
  on oi.product_id = p.id
group by p.category
order by revenue desc;

-- Завдання 3. Замовлення за окремими статусами
select
  status,
  count(*) as orders_count
from `bigquery-public-data.thelook_ecommerce.orders`
where status in ('Complete', 'Shipped')
group by status;

-- Завдання 4. Продажі по місяцях
select
  format_date('%Y-%m', DATE(created_at)) as month, 
  count(*) as items_sold, 
  round(avg(sale_price), 2) as avg_price
from `bigquery-public-data.thelook_ecommerce.order_items`
where extract(YEAR FROM created_at) in (2024, 2025)
group by month
order by month;

-- Завдання 5. Тільки великі категорії
select
  p.category,
  count(oi.product_id) as items_sold,
  round(sum(sale_price), 2) as revenue
from `bigquery-public-data.thelook_ecommerce.order_items` as oi
join `bigquery-public-data.thelook_ecommerce.products` as p 
  on oi.product_id = p.id
group by p.category
having round(sum(sale_price), 2) > 100000
order by revenue desc;

-- Завдання 6. Топ-10 товарів за виторгом
select
  p.name as product_name,
  p.brand,
  count(oi.product_id) as times_sold,
  round(sum(sale_price), 2) as revenue
from `bigquery-public-data.thelook_ecommerce.order_items` as oi
join `bigquery-public-data.thelook_ecommerce.products` as p 
  on oi.product_id = p.id
group by p.name, p.brand
order by revenue desc
limit 10;

-- Завдання 7. Відсоток повернень за категоріями
select
  p.category, 
  count(*) as total_items,
  COUNTIF(returned_at IS NOT NULL) as returned_items, 
  COUNTIF(returned_at IS NOT NULL)/count(*) * 100 as return_rate_pct
from `bigquery-public-data.thelook_ecommerce.order_items` as oi
join `bigquery-public-data.thelook_ecommerce.products` as p 
  on oi.product_id = p.id
group by p.category
order by return_rate_pct desc;

-- Завдання 8. Середній вік покупця за категорією
with
cte_buyers_category as (
  select
    p.category,
    u.id AS user_id,
    u.age
  from `bigquery-public-data.thelook_ecommerce.order_items` as oi 
  join `bigquery-public-data.thelook_ecommerce.products` as p 
    on oi.product_id = p.id
  join `bigquery-public-data.thelook_ecommerce.users` as u 
    on u.id = oi.user_id
)
select
  category, 
  count(distinct user_id) as buyers, 
  avg(age) as avg_age
from cte_buyers_category
group by category
order by avg_age desc;

-- Завдання 9. Рейтинг місяців за виторгом
select 
  extract(month from created_at) as month, 
  round(sum(sale_price), 2) as revenue, 
  rank() over (ORDER BY sum(sale_price) DESC) as revenue_rank
from `bigquery-public-data.thelook_ecommerce.order_items`
where extract(year from created_at) = 2025
group by month
order by revenue_rank asc;

-- Завдання 10. Приріст виторгу до попереднього місяця
with
cte_monthly_revenue as (
  select 
  extract(month from created_at) as month, 
  round(sum(sale_price), 2) as revenue
from `bigquery-public-data.thelook_ecommerce.order_items`
where extract(year from created_at) = 2025
group by month
)
select
  month,
  revenue, 
  lag(revenue) over (order by month) as prev_month_revenue, 
  round((revenue - lag(revenue) over (order by month))/lag(revenue) over (order by month)*100, 1) as growth_pct
from cte_monthly_revenue
order by month asc;

-- Завдання 11. Топ-3 товари в кожній категорії
with
cte_product_category_revenue as (
  select
    p.category,
    p.name as product_name,
    sum(oi.sale_price) as revenue
  from `bigquery-public-data.thelook_ecommerce.order_items` oi
  join `bigquery-public-data.thelook_ecommerce.products` p
    on oi.product_id = p.id
  group by p.category, p.name
)
select 
  category,
  product_name,
  round(revenue, 2) as revenue,
  rank() over (partition by category order by revenue desc) as rank_in_category
from cte_product_category_revenue
qualify rank_in_category <=3
order by category, rank_in_category;
