CREATE database retails_database;
-- create table

CREATE table retail(transactions_id int primary key,
						sale_date date,
                        sale_time time,
                        customer_id int,
                        gender varchar(15),
                        age int,
                        category varchar(15),
                        quantiy int,
                        price_per_unit float,
                        cogs float,
                        total_sale float
                        );
select * from retail;
use retails_database;
show tables;
show databases;
drop table retail;
select * from retail_sales_data
limit 10;

#to check the records in dataset
select count(*) from retail_sales_data;

select * from retail_sales_data;

select * from retail_sales_data
where sale_date  is NULL;

select * from retail_sales_data
where sale_time  is NULL;

select * from retail_sales_data
where sale_time  is NULL
or 
sale_time is NULL
or
gender is NULL
or 
category is NULL
or 
quantiy is NULL
or
cogs is NULL
or
total_sale is NULL;

SET SQL_SAFE_UPDATES = 0;
UPDATE retail_sales_data
SET age = NULL
WHERE age = 41;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM retail_sales_data
WHERE age IS NULL;

delete from retail_sales_data
where age is NULL;

select count(*) from retail_sales_data;

-- data explore
-- how much sales
select count(*) as total_sale from retail_sales_data;
-- customers count
select count(customer_id) as total_sales from retail_sales_data;
-- unique customers
select count(distinct customer_id) as total_sales from retail_sales_data;
-- find the catergory present
select distinct category from retail_sales_data;

-- Data Analysis problems
-- write sql query to retrive all columns for sales made on 18-05-2022
select * from retail_sales_data where sale_date='18-05-2022';

-- write a sql query to retrive all transactions where category is electronics and the quantity sold 
-- in months of nov 2022

select category, sum(quantiy) from retail_sales_data
where category='Electronics'
group by category;

select * from retail_sales_data
where category='Electronics' and date_format(sale_date,'%y-%m')='2022-11' and quantiy=4;

-- write a sql query to cal the total sales for each category
select category,sum(total_sale)as total_sales from retail_sales_data group by category;
select category,sum(total_sale)as total_sales,count(*) as total_count from retail_sales_data
 group by category;
 
 
-- write a sql query to find the average age of customers who purchased from beauty category

select round(avg(age),2)as avg_age from retail_sales_data
where category='Beauty';

-- write a sql query to find all transcations where the tota sale  is greater than 1000
select * from retail_sales_data 
where total_sale>1000;

-- write a sql query to find the total number of transactions made by each gender in each category
select category, gender,count(*) as total_transactions
from retail_sales_data group by category,gender
order by gender;

-- write a sql query to cal the average sale for each month.find the best selling month in each year
SELECT STR_TO_DATE(sale_date, '%d-%m-%Y')
FROM retail_sales_data;
SELECT sale_date,
       STR_TO_DATE(sale_date, '%d-%m-%Y') AS formatted_date
FROM retail_sales_data;
ALTER TABLE retail_sales_data
ADD COLUMN new_sale_date DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_data
SET new_sale_date = STR_TO_DATE(sale_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;
SELECT sale_date, new_sale_date
FROM retail_sales_data
LIMIT 10;
ALTER TABLE retail_sales_data
DROP COLUMN sale_date;
ALTER TABLE retail_sales_data
CHANGE new_sale_date sale_date DATE;
DESCRIBE retail_sales_data;
ALTER TABLE retail_sales_data
ADD COLUMN new_sale_date DATE;
SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_data
SET new_sale_date = STR_TO_DATE(sale_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;
SELECT sale_date, new_sale_date
FROM retail_sales_data
LIMIT 10;
ALTER TABLE retail_sales_data
DROP COLUMN sale_date;
ALTER TABLE retail_sales_data
CHANGE COLUMN new_sale_date sale_date DATE;
DESCRIBE retail_sales_data;
select * from retail_sales_data;
ALTER TABLE retail_sales_data
ADD COLUMN sale_date DATE;
-- trunacte
truncate table retail_sales_data;
-- import data again
select * from retail_sales_data;
drop table retail_sales_data;


SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM retail
GROUP BY 
    EXTRACT(YEAR FROM sale_date),
    EXTRACT(MONTH FROM sale_date)
ORDER BY 
    EXTRACT(YEAR FROM sale_date),
    EXTRACT(MONTH FROM sale_date) DESC;
    
-- write a sql query to find the top 5 customers based on the highest total  sales
select customer_id,sum(total_sale)  from retail
group by customer_id
order by sum(total_sale) desc
limit 5;

-- write a sql query to find the number of unique customers who purchased items from each category
select count(distinct customer_id)as unique_customer,category from retail
group by category;

-- write a sql query to create each shift and number of orders(example morning<=2,
-- afternoon btw 12-17, evening>17
select * from retail;
SET SQL_SAFE_UPDATES = 0;

UPDATE retail
SET sale_date = STR_TO_DATE(sale_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;
SELECT sale_date
FROM retail
LIMIT 10;


select *,
case
    when extract(hour from sale_time)<12 then 'Morning'
    when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
    else 'Evening'
end as shift
from retail;
    
With hourly_sales
as
(
select *,
case
    when extract(hour from sale_time)<12 then 'Morning'
    when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
    else 'Evening'
end as shift
from retail
)
select shift,
count(*) as total_orders
 from hourly_sales group by shift;
 
 
 -- end
    








