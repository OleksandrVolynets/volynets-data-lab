SET search_path TO hr; -- додав, щоб запити виконувались у потрібній схемі

-- Завдання 1.3
SELECT COUNT(*) AS employees_total FROM employees;

-- Завдання 2.1
select 
	first_name,
	last_name 
from employees
where manager_id = 101
order by employee_id asc;

-- Завдання 2.2
select 
	first_name,
	last_name,
	salary
from employees
where salary < 4_000
order by salary asc;

-- Завдання 2.3
select
	employee_id, 
	first_name, 
	last_name, 
	hire_date
from employees
where hire_date between date '1996-01-01' and date '1996-12-31'
order by hire_date asc;

-- Завдання 2.4
select 
	employee_id,
	first_name,
	last_name,
	email
from employees
where email like '%example.com'
order by email asc;

-- Завдання 2.5
select 
	employee_id, 
	first_name, 
	last_name, 
	department_id
from employees
where department_id in (20, 30)
order by department_id,
	employee_id asc;

-- Завдання 2.6
select 
	employee_id, 
	first_name
from employees
where lower(first_name) like '%a'
order by first_name asc;

-- Завдання 2.7
select
	employee_id,
	first_name,
	last_name,
	salary, 
	commission_pct
from employees
where salary > 6_000 and commission_pct = 0.15
order by salary desc;

-- Завдання 2.8
select
	employee_id,
	first_name, 
	last_name,
	phone_number
from employees
where phone_number like '515%'
order by phone_number asc;

-- Завдання 2.9
select 
	employee_id, 
	first_name, 
	last_name, 
	salary
from employees
where department_id = 20 
order by salary desc;

-- Завдання 2.10
select 
	employee_id, 
	first_name, 
	last_name, 
	hire_date
from employees
order by hire_date,
	employee_id
limit 7;

-- Завдання 2.11
select 
	employee_id, 
	first_name, 
	last_name, 
	salary
from employees
where salary > 4_000
order by employee_id asc 
limit 5;

-- Завдання 2.12
select 
	employee_id, 
	first_name,
	last_name,
	CAST(salary AS TEXT) || ' EUR' AS salary_eur
from employees
order by employee_id asc;

-- Завдання 2.13
select 
	employee_id, 
	first_name, 
	last_name
from employees
where manager_id = 101
order by last_name asc;

-- Завдання 2.14
select 
	employee_id, 
	first_name, 
	last_name, 
	salary
from employees
order by salary desc
offset 3
limit 10;

-- Завдання 2.15
select 
	employee_id, 
	first_name, 
	last_name, 
	hire_date
from employees
where hire_date > '2000-01-01'
order by hire_date desc;

-- Завдання 3.1
select 
	ROUND(AVG(salary), 2) as avg_salary
from employees
where job_id like 'S%';

-- Завдання 3.2
select 
	department_id, 
	min(salary) as min_salary,
	max(salary) as max_salary
from employees
group by department_id 
order by department_id asc;

-- Завдання 3.3
select 
	count(employee_id ) as employees_count
from employees
where salary > 3_000;

-- Завдання 3.4
select
	department_id,
	sum(salary) as total_salary
from employees
group by department_id
having sum(salary) > 10_000
order by total_salary desc;

-- Завдання 3.5
select 
	employee_id, 
	first_name, 
	last_name,
	coalesce(commission_pct, 0) as commission_pct
from employees
order by employee_id asc;

-- Завдання 3.6
select
	employee_id, 
	last_name,
	salary + salary * COALESCE(commission_pct, 0) as total_income
from employees
group by employee_id, 
	last_name
having salary + salary * COALESCE(commission_pct, 0) > 5_000
order by total_income desc;

-- Завдання 4.1
select 
	e.first_name, 
	e.last_name,
	j.job_title 
from employees as e
join jobs as j 
	on e.job_id = j.job_id 
order by last_name asc;

-- Завдання 4.2
select 
	e.first_name, 
	e.last_name, 
	e.salary, 
	j.job_title
from employees as e 
join jobs as j 
	on e.job_id = j.job_id 
where e.salary > 5_000
order by e.salary desc;

-- Завдання 4.3
select 
	e.first_name, 
	e.last_name,
	d.department_name
from employees as e 
left join departments as d 
	on d.department_id = e.department_id 
order by last_name asc;

-- Завдання 4.4
select 
	d.department_name,
	e.first_name, 
	e.last_name
from employees as e
right join departments as d 
	on d.department_id = e.department_id 
order by d.department_name asc;

-- Завдання 4.5
select 
	e.first_name, 
	e.last_name, 
	d.department_name
from employees as e
full outer join departments as d 
	on d.department_id = e.department_id 
order by d.department_name,
	e.last_name asc;

-- Завдання 4.6
select 
	e.first_name, 
	e.last_name, 
	j.job_title, 
	d.department_name
from employees as e
join jobs as j 
	on e.job_id = j.job_id 
full outer join departments as d 
	on d.department_id = e.department_id 
order by d.department_name,
	e.last_name asc;

-- Завдання 4.7
select 
	d.department_name, 
	count(e.employee_id) as employees_count
from employees as e
full outer join departments as d 
	on d.department_id = e.department_id
group by d.department_name
order by employees_count desc;

-- Завдання 4.8
select 
	d.department_name, 
	count(e.employee_id) as employees_count
from employees as e
full outer join departments as d 
	on d.department_id = e.department_id
group by d.department_name
having count(e.employee_id) > 3
order by employees_count desc;

-- Завдання 4.9
select 
	d.department_name, 
	c.country_name
from departments as d 
left join locations as l
	on l.location_id = d.location_id 
left join countries as c
	on c.country_id = l.country_id 
order by c.country_name,
	d.department_name asc;

-- Завдання 4.10
select 
	e.first_name, 
	e.last_name, 
	d.department_name
from employees as e 
join departments as d 
	on d.department_id = e.department_id
join locations as l
	on l.location_id = d.location_id 
join countries as c
	on c.country_id = l.country_id 
join regions as r 
	on r.region_id = c.region_id 	
	and r.region_name like 'Europe'
order by e.last_name asc;

-- Завдання 5.1
select 
	employee_id, 
	first_name, 
	last_name,
	salary
from employees as e 
where salary > (SELECT AVG(salary) FROM employees)
order by salary desc;

-- Завдання 5.2
select 
	d.department_id, 
	d.department_name
from departments as d 
where d.department_id in (
	select 
		e.department_id
	from employees as e 
	group by e.department_id
	having sum(salary) > 100_000
	)
order by department_id asc;

-- Завдання 5.3
select
	e.employee_id, 
	e.first_name, 
	e.last_name
from employees as e
join departments as d 
	on d.department_id = e.department_id 
	and d.location_id in (
		select l.location_id from locations as l 
		where l.city like 'S%')
order by e.employee_id asc;

-- Завдання 5.4
select 
	e.employee_id, 
	e.last_name, 
	e.salary, 
	e.job_id
from employees as e
where e.salary > (
	select j.max_salary from jobs as j 
	where j.job_id = e.job_id)
order by e.salary desc;

-- Завдання 5.5
select 
	d.department_id, 
	d.department_name
from departments as d
where not exists (
	select 1 from employees as e 
	where e.department_id = d.department_id )
order by d.department_id  asc;

-- Завдання 5.6.
select 
	e.department_id, 
	count(e.employee_id ) as employees_count
from employees as e 
where exists (
	select
		e1.department_id,
		avg(e1.salary) as avg_salary_department 
	from employees as e1 
	where e.department_id = e1.department_id
	group by e1.department_id
	having avg(e1.salary) > 15_000)
group by e.department_id
order by department_id asc;