drop table if exists customer_data,
	employees,
	events,
	orders,
	product_catalog,
	products,
	products_with_categories;

-- Створення тестової таблиці
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    discount DECIMAL(4, 2)
);

-- Вставка тестових даних
INSERT INTO products (name, price, discount) VALUES
    ('Ноутбук', 25000.75, 0.15),
    ('Смартфон', 12500.00, 0.10),
    ('Навушники', 3500.00, 0.05),
    ('Планшет', 15000.00, 0.12),
    ('Клавіатура', 20000.43, NULL);
    
  -- Створення тестової таблиці замовлень 
CREATE TABLE orders ( 
    id SERIAL PRIMARY KEY, 
    customer_id INTEGER, 
    order_date DATE, 
    total_amount DECIMAL(10, 2), 
    region VARCHAR(50) 
); 

-- Вставка тестових даних 
INSERT INTO orders (customer_id, order_date, total_amount, region) VALUES 
    (1, '2023-01-15', 2500.00, 'Київ'), 
    (2, '2023-01-18', 1800.50, 'Львів'), 
    (1, '2023-02-05', 3250.75, 'Львів'), 
    (3, '2023-02-10', 5000.00, 'Одеса'), 
    (2, '2023-03-01', 1250.25, 'Львів'), 
    (4, '2023-03-15', 4300.00, 'Харків'), 
    (1, '2023-03-20', 2100.50, 'Київ'), 
    (3, '2023-04-05', 3850.75, 'Одеса');
    
  -- Створення тестової таблиці 
CREATE TABLE employees ( 
    id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    email VARCHAR(100), 
    bio TEXT, 
    department VARCHAR(50) 
); 

-- Вставка тестових даних 
INSERT INTO employees (first_name, last_name, email, bio, department) VALUES 
    ('Олександр', 'Петренко', 'oleksandr.petrenko@example.com', 'Досвід роботи 5 років у розробці програмного забезпечення', 'IT'), 
    ('Марія', 'Коваленко', 'maria.kovalenko@example.com', 'Спеціаліст з маркетингу з досвідом роботи у великих компаніях', 'Маркетинг'), 
    ('Іван', 'Сидоренко', 'ivan.sydorenko@example.com', 'Має ступінь магістра в галузі фінансів', 'Фінанси'), 
    ('Олена', 'Шевченко', 'olena.shevchenko@example.com', ' Досвідчений HR-менеджер ', 'HR'), 
    ('Андрій', 'Мельник', 'andrii.melnyk@example.com', 'Працює в компанії з 2018 року', 'продажі');
    
  -- Створення тестової таблиці
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    registration_deadline DATE
);

-- Вставка тестових даних
INSERT INTO events (event_name, start_date, end_date, registration_deadline) VALUES
    ('Конференція з розробки ПЗ', '2023-06-15 09:00:00', '2023-06-17 18:00:00', '2023-06-01'),
    ('Семінар з маркетингу', '2023-07-10 10:00:00', '2023-07-10 16:00:00', '2023-07-05'),
    ('Тренінг з управління проектами', '2023-08-05 09:30:00', '2023-08-07 17:30:00', '2023-07-25'),
    ('Воркшоп з дизайну', '2023-09-12 13:00:00', '2023-09-12 18:00:00', '2023-09-08'),
    ('Хакатон', '2026-10-20 18:00:00', '2026-10-22 20:00:00', '2027-10-10');
   
  -- Створення тестової таблиці
CREATE TABLE customer_data (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    last_purchase_date DATE,
    total_purchases INTEGER
);

-- Вставка тестових даних з NULL значеннями
INSERT INTO customer_data (name, email, phone, address, last_purchase_date, total_purchases) VALUES
    ('Андрій Іваненко', 'andrii@example.com', '+380501234567', 'вул. Шевченка, 10, Київ', '2023-03-15', 5),
    ('Олена Петренко', NULL, '+380671234567', NULL, '2023-04-10', 3),
    ('Максим Сидоренко', 'maksym@example.com', NULL, 'вул. Франка, 25, Львів', NULL, 0),
    ('Ірина Коваль', 'iryna@example.com', '+380931234567', 'вул. Сагайдачного, 5, Одеса', '2023-05-20', NULL),
    ('Тарас Шевченко', NULL, NULL, NULL, NULL, NULL);
    
  -- Створення таблиці з JSONB полем
CREATE TABLE product_catalog (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    attributes JSONB,
    tags JSONB
);

-- Вставка тестових даних
INSERT INTO product_catalog (name, attributes, tags) VALUES
    ('Смартфон Galaxy S21', '{"brand": "Samsung", "model": "S21", "specs": {"screen": "6.2 inch", "camera": "64MP", "battery": "4000mAh", "memory": {"ram": "8GB", "storage": "128GB"}}}', '["electronics", "smartphones", "android"]'),
    ('Ноутбук MacBook Pro', '{"brand": "Apple", "model": "MacBook Pro 16", "specs": {"screen": "16 inch", "processor": "Apple M1 Pro", "memory": {"ram": "16GB", "storage": "512GB"}}}', '["electronics", "laptops", "apple"]'),
    ('Бездротові навушники AirPods', '{"brand": "Apple", "model": "AirPods Pro", "specs": {"battery": "24h with case", "noise_cancellation": true}}', '["electronics", "audio", "wireless"]'),
    ('Смарт-годинник Versa', '{"brand": "Fitbit", "model": "Versa 3", "specs": {"screen": "1.58 inch", "battery": "6+ days", "gps": true}}', '["electronics", "wearables", "fitness"]'),
    ('Ігрова консоль PS5', '{"brand": "Sony", "model": "PlayStation 5", "specs": {"storage": "825GB SSD", "resolution": "4K", "fps": 120}}', '["electronics", "gaming", "consoles"]');
    
   -- Створення таблиці з масивами
CREATE TABLE products_with_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    categories TEXT[],
    specifications VARCHAR(100)[]
);

-- Вставка тестових даних
INSERT INTO products_with_categories (name, price, categories, specifications)
VALUES
    ('Смартфон XYZ', 12500.00, ARRAY['Електроніка', 'Смартфони', 'Гаджети'], ARRAY['Екран 6.5"', 'RAM 8GB', 'Камера 48MP']),
    ('Ноутбук ABC', 28000.00, ARRAY['Електроніка', 'Комп''ютери', 'Ноутбуки'], ARRAY['Екран 15.6"', 'Intel i7', 'SSD 512GB']),
    ('Навушники QWE', 3500.00, ARRAY['Електроніка', 'Аудіо'], ARRAY['Bluetooth 5.0', 'Час роботи 24г']),
    ('Планшет RST', 15000.00, ARRAY['Електроніка', 'Планшети', 'Гаджети'], ARRAY['Екран 10"', 'RAM 6GB', 'Камера 12MP']),
    ('Кавомашина UVW', 9500.00, ARRAY['Техніка для дому', 'Кухонна техніка'], ARRAY['Тиск 15 бар', 'Резервуар 1.5л']);

-- Завдання 1.3
SELECT 'products' AS t, COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'events', COUNT(*) FROM events
UNION ALL SELECT 'customer_data', COUNT(*) FROM customer_data
UNION ALL SELECT 'product_catalog', COUNT(*) FROM product_catalog
UNION ALL SELECT 'products_with_categories', COUNT(*) FROM products_with_categories;

-- Завдання 2.1
select
	name, 
	price, 
	ceil(price) as price_ceil, 
	round(sqrt(price), 2)::numeric as price_sqrt
from products
order by id;

-- Завдання 2.2
select 
	name, 
	price, 
	mod(price, 1000) as price_rest
from products
order by id;

-- Завдання 2.3
select 
	name, 
	coalesce(discount, 0) as discount,
	case when coalesce(discount, 0) < 0.07 then 'Мінімальна' 
		when coalesce(discount, 0) < 0.12 then 'Середня'
		else 'Висока' end as discount_level
from products
order by id;

-- Завдання 2.4
select 
	name, 
	round(price * coalesce(discount, 0), 2) as money_discount, 
	greatest(round(price * coalesce(discount, 0)::numeric, 2), 1000) as max_discount
from products
order by id;

-- Завдання 2.5. 
select 
	name, 
	price,
	least(price, 18000) as capped_price
from products
order by id;

-- Завдання 3.1.
select 
	count(*) as orders_count,
	sum(total_amount) as total_sales,
	round(avg(total_amount), 2) as avg_amount,
	min(total_amount) as min_amount,
	max(total_amount) as max_amount 
from orders;

-- Завдання 3.2.
select 
	region,
	count(*) as orders_count,
	sum(total_amount) as total_sales,
	round(avg(total_amount), 2) as avg_amount
from orders
group by region
order by total_sales desc;

-- Завдання 3.3.
select
	customer_id, 
	count(*) as orders_count, 
	sum(total_amount) as total_spent
from orders
group by customer_id
having count(*) > 1
order by customer_id;

-- Завдання 3.4.
select 
	customer_id, 
	count(distinct region) as regions_count, 
	string_agg(distinct region, ', ' order by region) as regions
from orders
group by customer_id
having count(distinct region) > 1;

-- Завдання 3.5. 
select 
	region,
	round(avg(total_amount), 2) as avg_amount,
	round(stddev(total_amount), 2) as stddev_amount,
	round(variance(total_amount), 2) as variance_amount
from orders
group by region
order by region;

-- Завдання 4.1.
select 
	id, 
	first_name, 
	last_name, 
	lower(left(last_name, 3) || left(first_name, 3) || id::text) as login
from employees
order by id;

-- Завдання 4.2.
select 
	id, 
	first_name, 
	last_name, 
	length(bio) as bio_length, 
	left(bio, 50) || '...' as bio_short
from employees
where length(bio) > 50
order by id;

-- Завдання 4.3.
select 
	id, 
	department, 
	rtrim(ltrim(department)) as department_trimmed, 
	bio, 
	rtrim(ltrim(bio)) as bio_trimmed
from employees
where department != rtrim(ltrim(department)) 
	or bio != rtrim(ltrim(bio))
order by id;

-- Завдання 4.4.
select distinct
	split_part(email, '@', 2) as domain
from employees;

-- Завдання 4.5.
INSERT INTO employees (first_name, last_name, email, bio, department)
VALUES ('Софія', 'Кравчук Мельник', 'sofiia.kravchuk@example.com',
        'Аналітик даних', 'IT');

select 
	id, 
	first_name, 
	last_name
from employees
where position(' ' in trim(last_name)) > 0
order by id;

-- Завдання 4.6.
select 
	department, 
	string_agg(bio, '; ' order by department) as bios
from employees
group by department;

-- Завдання 4.7.
select 
	lpad(id::text, 5, '*') as padded_id, 
	first_name, 
	last_name
from employees
order by id;

-- Завдання 5.1.
select
	event_name, 
	round(extract (hour from end_date-start_date), 1) as duration_hours, 
	round(extract (day from end_date-start_date), 2) as duration_days
from events e
order by id;

-- Завдання 5.2.
select 
	event_name, 
	to_char(start_date, 'DD.MM.YYYY HH24:MI')as start_formatted, 
	to_char(end_date, 'Month DD, YYYY') as end_formatted
from events
order by id;

-- Завдання 5.3.
select 
	event_name, 
	start_date, 
	case when start_date < now() then 'Минуле' else 'Майбутнє' end as status
from events
order by id;

-- Завдання 5.4.
select 
	 event_name, 
	 registration_deadline, 
	 start_date, 
	 registration_deadline - start_date as days_before_start
from events 
where registration_deadline - start_date > interval '-7 days'
order by id;

-- Завдання 5.5.
select
	event_name, 
	to_char(start_date, 'day'),
	case to_char(start_date, 'FMday')
		when 'monday' then 'понеділок'
		when 'tuesday' then 'вівторок'
		when 'wednesday' then 'середа'
		when 'thursday' then 'четвер'
		when 'friday' then 'п`ятниця'
		when 'saturday' then 'субота'
		when 'sunday' then 'неділя'
		end as weekday
from events
order by id;

-- Завдання 5.6. 
select 
	event_name, 
	start_date, 
	start_date - interval '3 day' as reminder_date
from events
order by id;

-- Завдання 5.7.
select 
	event_name, 
	extract (year from start_date) as event_year,
	extract (month from start_date) as event_month, 
	extract (quarter from start_date) as event_quarter
from events 
order by id;

-- Завдання 6.1.
select
	name,
	case 
		when email is not null and phone is not null then 'Є обидва'
		when email is not null then 'Є email'
		when phone is not null then 'Є телефон'
		else 'Контактні дані відсутні'
	end
	as contact_status
from customer_data
order by id;

-- Завдання 6.2.
select 
	name, 
	coalesce(email, 'Немає email') as email, 
	coalesce(phone, 'Немає телефону') as phone,
	coalesce(address, 'Адреса не вказана') as address,
	coalesce(total_purchases, 0) as total_purchases,
	coalesce(to_char(last_purchase_date, 'YYYY-MM-DD'), 'Немає покупок') as last_purchase_date
from customer_data
order by id;

-- Завдання 6.3.
select 
	id, 
	name, 
	total_purchases
from customer_data
where total_purchases is null or total_purchases = 0
order by id;

-- Завдання 6.4.
select 
	id, 
	name
from customer_data
where email is null and phone is null
order by id;

-- Завдання 6.5.
select 
	count(name) as total, 
	count(email) as with_email, 
	count(phone) as with_phone, 
	count(address) as with_address,
	count(
        case
            when email is null
            and phone is null
            and address is null
            then 1
        end
    ) as with_nothingwith_nothing
from customer_data;

-- Завдання 7.1. 
select
	name, 
	attributes -> 'brand' as brand, 
	coalesce((attributes -> 'specs' -> 'memory' ->> 'ram'), 'Не вказано') as ram
from product_catalog
order by id;

-- Завдання 7.2.
select
	name, 
	attributes -> 'specs' ->> 'battery' as battery
from product_catalog
where attributes -> 'specs' ? 'battery' 
order by id;

-- Завдання 7.3.
select 
	name, 
	tags
from product_catalog
where  tags @> '["gaming"]' or tags @> '["wearables"]' or tags @> '["audio"]'
order by id;

-- Завдання 7.4.
select
	count(attributes -> 'specs' ->> 'screen') as  with_screen,
	count(attributes -> 'specs' ->> 'battery') as with_battery,
	count(attributes -> 'specs' ->> 'gps') as with_gps,
	count(*) filter (
		where 
			attributes -> 'specs' ? 'gps'
			or attributes -> 'specs' ? 'battery'
			or attributes -> 'specs' ? 'screen'
			) as with_any
from product_catalog;

-- Завдання 7.5.
select 
	name, 
	kv.key as attr_key, 
	kv.value as attr_value
from product_catalog,
jsonb_each(attributes) as kv
order by id;

-- Завдання 7.6.
select
	jsonb_build_object(
		'brand', attributes -> 'brand',
		'names', jsonb_agg(name ORDER BY name)) as products 
from product_catalog 
group by attributes -> 'brand';

-- Завдання 7.7.
update product_catalog 
set attributes = jsonb_set(
	attributes,
	'{specs, warranty}',
	'"1 рік"'::jsonb,
	true);

select 
	name,
	attributes -> 'specs' ->> 'warranty' as warranty
from product_catalog
order by id;

-- Завдання 8.1.
select string_agg(name, ', ' order by id) AS products
from products_with_categories;

-- Завдання 8.2.
select 
	name, 
	categories, 
	array_length(categories, 1) as categories_count
from products_with_categories
order by id;

-- Завдання 8.3.
select
	name, 
	categories
from products_with_categories
where categories && array['Гаджети', 'Ноутбуки', 'Аудіо']
order by id;

-- Завдання 8.4.
select 
	name,
	unnest(specifications) as specification
from products_with_categories
order by id;

-- Завдання 8.5.
select
    name,
    (
        select count(*)
        from unnest(specifications) as spec
        where spec ~ '[0-9]'
    ) as numeric_specs_count
from products_with_categories
where (
    select count(*)
    from unnest(specifications) as spec
    where spec ~ '[0-9]'
) >= 2;

-- Завдання 8.6.
select
    category,
    count(*) as products_count,
    sum(price) as total_price
from products_with_categories,
     unnest(categories) as category
group by category
order by total_price desc;

-- Завдання 8.7.
update products_with_categories
set categories = categories || array['Топ-продаж']
where not ('Топ-продаж' = any(categories));

select
    name,
    categories
from products_with_categories
order by id;

