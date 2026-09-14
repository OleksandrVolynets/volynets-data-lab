-- створення та наповнення таблиць
DROP TABLE IF EXISTS sales, stock_prices;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    store_id INT,
    product_id INT,
    sale_date DATE,
    quantity_sold INT,
    total_amount DECIMAL(10,2)
);
INSERT INTO sales (store_id, product_id, sale_date, quantity_sold, total_amount) VALUES
(1, 101, '2024-03-01', 5, 500),
(1, 102, '2024-03-01', 2, 200),
(1, 101, '2024-03-02', 3, 300),
(2, 103, '2024-03-02', 7, 700),
(2, 101, '2024-03-03', 4, 400),
(3, 102, '2024-03-03', 6, 600),
(3, 103, '2024-03-04', 8, 800),
(1, 101, '2024-03-05', 2, 200),
(2, 102, '2024-03-05', 3, 300),
(3, 103, '2024-03-06', 5, 500);

CREATE TABLE stock_prices (
    stock_id SERIAL PRIMARY KEY,
    stock_symbol VARCHAR(10),
    price_date DATE,
    closing_price DECIMAL(10,2)
);
INSERT INTO stock_prices (stock_symbol, price_date, closing_price) VALUES
('AAPL', '2024-03-01', 150),
('AAPL', '2024-03-02', 152),
('AAPL', '2024-03-03', 148),
('AAPL', '2024-03-04', 155),
('AAPL', '2024-03-05', 157),
('GOOGL', '2024-03-01', 2800),
('GOOGL', '2024-03-02', 2820),
('GOOGL', '2024-03-03', 2790),
('GOOGL', '2024-03-04', 2850),
('GOOGL', '2024-03-05', 2875);

-- Завдання 1.3.
SELECT 'sales' AS t, COUNT(*) FROM sales
UNION ALL
SELECT 'stock_prices', COUNT(*) FROM stock_prices;

-- Завдання 2.1.
select 
	store_id,
	sum(total_amount) as sum_total_amount
from sales
group by store_id;

select 
	sale_id,
	store_id,
	total_amount,
	sum(total_amount) over () as sum_total_amount
from sales
order by sale_id;

-- Завдання 2.2.
select 
	sale_id,
	store_id,
	total_amount,
	round(avg(total_amount) over (), 2) as avg_all
from sales
order by sale_id;

-- Завдання 2.3.
select 
	sale_id, 
	total_amount, 
	count(*) over () as sales_count
from sales
order by sale_id;

-- Завдання 2.4.
select 
	sale_id,
	store_id,
	total_amount,
	round(total_amount/sum(total_amount) over ()*100, 2) as pct_of_total
from sales
order by sale_id;

-- Завдання 2.5.
select 
	sale_id,
	store_id,
	total_amount,
	dense_rank() over (order by total_amount desc) as overall_rank
from sales
order by overall_rank;

-- Завдання 3.1.
select 
	sale_id,
	store_id,
	total_amount,
	round(avg(total_amount) over (partition by store_id), 2) as avg_store_sales
from sales
order by store_id, sale_id;

-- Завдання 3.2.
select 
	sale_id,
	store_id,
	total_amount,
	round(avg(total_amount) over w, 2) as avg_store_sales,
	sum(total_amount) over w as store_total,
	min(total_amount) over w as store_min,
	max(total_amount) over w as store_max,
	count(*) over w as store_sales_cnt
from sales
window w as (partition by store_id)
order by store_id, sale_id;

-- Завдання 3.3.
select 
	sale_id,
	store_id,
	total_amount,
	round(avg(total_amount) over w, 2) as avg_store_sales,
	sum(total_amount) over w as store_total,
	min(total_amount) over w as store_min,
	max(total_amount) over w as store_max,
	count(*) over w as store_sales_cnt,
	round(total_amount - avg(total_amount) over w, 2) as diff_from_avg 
from sales
window w as (partition by store_id)
order by store_id, sale_id;

-- Завдання 3.4.
select 
	sale_id,
	store_id,
	total_amount,
	round(avg(total_amount) over w, 2) as avg_store_sales,
	sum(total_amount) over w as store_total,
	min(total_amount) over w as store_min,
	max(total_amount) over w as store_max,
	count(*) over w as store_sales_cnt,
	round(total_amount - avg(total_amount) over w, 2) as diff_from_avg,
	round(total_amount/sum(total_amount) over w * 100, 2) as pct_of_store
from sales
window w as (partition by store_id)
order by store_id, sale_id;

-- Завдання 3.5.
with
cte_avg_sales_store as (
	select 
		sale_id, 
		store_id, 
		total_amount, 
		avg(total_amount) over (partition by store_id) as avg_store_sales
	from sales
)
select 
	* 
from cte_avg_sales_store
where total_amount > avg_store_sales;

-- Завдання 4.1.
select 
	s.*,
	row_number() over (partition by store_id order by sale_date, sale_id) as sale_rank
from sales as s;

-- Завдання 4.2.
select 
	sale_id, 
	store_id, 
	total_amount,
	rank() over (partition by store_id order by total_amount desc) as amount_rank
from sales;

-- Завдання 4.3.
select 
	sale_id, 
	store_id, 
	total_amount,
	rank() over (partition by store_id order by total_amount desc) as amount_rank,
	dense_rank() over (partition by store_id order by total_amount desc) as amount_dense 
from sales;
-- магазин з різними даними в колонках amount_rank та amount_dense відсутній. було б більше даних в таблицях - ми б побачили,
-- що amount_dense вивів би цифри без пропущених значень

-- Завдання 4.4.
select 
	sale_id, 
	store_id, 
	total_amount,
	ntile(2) over (partition by store_id order by total_amount desc) as half 
from sales;

-- Завдання 4.5.
select 
	sale_id, 
	store_id, 
	sale_date,
	total_amount,
	row_number() over (partition by sale_date order by total_amount desc) as date_rank 
from sales;

-- Завдання 4.6. 
select 
	sale_id, 
	store_id, 
	sale_date,
	product_id,
	total_amount,
	row_number() over (partition by product_id order by sale_date, sale_id) as product_rank  
from sales;

-- Завдання 5.1.
select 
	sale_id, 
	store_id, 
	lag(total_amount) over w as previous_sale_amount 
from sales
window w as (partition by store_id order by sale_date, sale_id);

-- Завдання 5.2.
select 
	sale_id, 
	store_id, 
	total_amount,
	lag(total_amount) over w as previous_sale_amount,
	lead(total_amount) over w as next_sale_amount 
from sales
window w as (partition by store_id order by sale_date, sale_id);

-- Завдання 5.3.
select 
	sale_id, 
	store_id, 
	total_amount,
	lag(total_amount) over w as previous_sale_amount,
	lead(total_amount) over w as next_sale_amount,
	total_amount - lag(total_amount) over w as diff_prev 
from sales
window w as (partition by store_id order by sale_date, sale_id);

-- Завдання 5.4.
select 
	sale_id, 
	store_id, 
	total_amount,
	coalesce(lag(total_amount) over w, 0) as previous_sale_amount,
	lag(total_amount, 1, 0) over w as previous_sale_amount2
from sales
window w as (partition by store_id order by sale_date, sale_id);

-- Завдання 5.5.
select 
	sale_id, 
	store_id, 
	total_amount,
	lag(total_amount, 2, 0) over w as two_sales_ago 
from sales
window w as (partition by store_id order by sale_date, sale_id);

-- Завдання 5.6.
select 
	sale_id, 
	store_id, 
	total_amount,
	lag(total_amount) over w as previous_sale_amount,
	case 
		when lag(total_amount) over w is null
			then 'перший продаж'
		when total_amount - lag(total_amount) over w > 0
			then 'зростання'
		when total_amount - lag(total_amount) over w < 0
			then 'падіння'
		else 'без змін'
	end
	as trend
from sales
window w as (partition by store_id order by sale_date, sale_id);

-- Завдання 6.1.
select
	sale_id, 
	store_id, 
	total_amount,
	sum(total_amount) over (partition by store_id order by sale_date, sale_id) as cumulative_store_sales 
from sales;

-- Завдання 6.2.
select
	sale_id, 
	store_id, 
	quantity_sold,
	sum(quantity_sold) over (partition by store_id order by sale_date, sale_id) as cumulative_qty 
from sales;

-- Завдання 6.3. 
select
	sale_id, 
	store_id, 
	quantity_sold,
	AVG(total_amount) OVER (PARTITION BY store_id ORDER BY sale_date, sale_id
                        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3rows 
from sales;

-- Завдання 6.4. 
select
	sale_id, 
	store_id, 
	quantity_sold,
	AVG(total_amount) OVER (PARTITION BY store_id ORDER BY sale_date, sale_id
                        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3rows,
    AVG(total_amount) OVER (PARTITION BY store_id ORDER BY sale_date
                        RANGE BETWEEN INTERVAL '2 days' PRECEDING AND CURRENT ROW) as moving_avg_3days                        
from sales;

-- Завдання 6.5.
select
	sale_id, 
	store_id, 
	quantity_sold,
	total_amount,
	max(total_amount) over (partition by store_id ORDER BY sale_date, sale_id
							rows between unbounded preceding and current row) as running_max 
from sales;

-- Завдання 7.1.
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	lag(closing_price) over (partition by stock_symbol order by price_date) as yesterday_price,
	lead(closing_price) over (partition by stock_symbol order by price_date) as tomorrow_price
from stock_prices;

-- Завдання 7.2.
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	closing_price - lag(closing_price) over (partition by stock_symbol order by price_date) as price_delta
from stock_prices;

-- Завдання 7.3.
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	closing_price - lag(closing_price) over (partition by stock_symbol order by price_date) as price_delta,
	round((closing_price - lag(closing_price) over (partition by stock_symbol order by price_date))/closing_price * 100, 2) as pct_change 
from stock_prices;

-- Завдання 7.4.
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	first_value(closing_price) over (partition by stock_symbol order by price_date) as first_price,
	round((closing_price - first_value(closing_price) over (partition by stock_symbol order by price_date))/closing_price * 100, 2) as growth_from_start_pct 
from stock_prices;

-- Завдання 7.5.
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	max(closing_price) over (partition by stock_symbol) as max_price,
	closing_price - max(closing_price) over (partition by stock_symbol) as diff_from_max 
from stock_prices;

-- Завдання 7.6.
with 
cte_final as (
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	closing_price - lag(closing_price) over (partition by stock_symbol order by price_date) as price_delta
from stock_prices
)
select 
	stock_id,
	stock_symbol,
	price_date,
	closing_price,
	price_delta,
	SUM(COALESCE(price_delta, 0))
           OVER (PARTITION BY stock_symbol ORDER BY price_date) as cumulative_change 
from cte_final;

-- Завдання 8.1.
SELECT *
FROM (
    SELECT sale_id, store_id, total_amount,
           ROW_NUMBER() OVER (PARTITION BY store_id
                              ORDER BY total_amount DESC, sale_id) AS rn
    FROM sales
) t
WHERE rn = 1;

-- Завдання 8.2.
select distinct
	store_id, 
	first_value(sale_date) over (partition by store_id order by sale_date) as first_sale_date,
	first_value(sale_date) over (partition by store_id order by sale_date desc) as last_sale_date, 
	first_value(sale_date) over (partition by store_id order by sale_date desc) - first_value(sale_date) over (partition by store_id order by sale_date) as days_between
from sales;

-- Завдання 8.2.
select 
	product_id, 
	sum(total_amount) as product_total, 
	rank() over (order by sum(total_amount) desc) product_rank
from sales
group by product_id;



