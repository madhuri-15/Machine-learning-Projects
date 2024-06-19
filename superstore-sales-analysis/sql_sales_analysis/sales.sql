
-- Create a table
CREATE TABLE df_order(
order_id CHAR(14),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(50),
customer_id CHAR(8),
customer_name VARCHAR(50),
segment VARCHAR(50),
country VARCHAR(100),
city VARCHAR(200), 
state VARCHAR(200), 
postal_code INT, 
region VARCHAR(80), 
product_id VARCHAR(100), 
category VARCHAR(200), 
sub_category VARCHAR(200), 
product_name VARCHAR(300), 
sales FLOAT
);

-- find top 10 highest reveue generating products
select product_id, sum(sales) as total_sales
from df_order
group by product_id
order by total_revenue desc
limit 10;


-- find top 5 highest selling products in each region 
with cte as (
select region, product_id, sum(sales) as total_sales
from df_order
group by region, product_id
)

select *,
row_number() over(partition by region order by total_sales desc) as row_id
from cte
order by row_id
limit 4;


-- find month over month growth comparison for 2015 to 2018 sales eg : jan 2015 vs jan 2016
with cte as(
select year(order_date) as yr, month(order_date) as mth, sum(sales) as tsales
from df_order
group by yr, mth
)
select mth
, sum(case when yr = 2015 then tsales else 0 end) as sales_2015
, sum(case when yr = 2016 then tsales else 0 end) as sales_2016
, sum(case when yr = 2017 then tsales else 0 end) as sales_2017
, sum(case when yr = 2018 then tsales else 0 end) as sales_2018
from cte
group by mth
order by mth;


-- for each category which month had highest sales over the years
with cte as (
select category, date_format(order_date, '%Y-%m') as yrmth, sum(sales) as tsales
from df_order
group by category, yrmth
)

select *,
row_number() over(partition by category order by tsales desc) as row_id
from cte
order by row_id
limit 3;


-- which sub category had highest growth percentage by profit last two years 2017 and 2018
with sub_cte as (
select sub_category, year(order_date) as order_yr, sum(sales) as tsales
from df_order
group by sub_category, order_yr
having order_yr in (2017, 2018)
)
, cte2 as (select sub_category
		, sum(case when order_yr = 2017 then tsales else 0 end) as sales_2017
		, sum(case when order_yr = 2018 then tsales else 0 end) as sales_2018
		from sub_cte
		group by sub_category)
        
select sub_category, 
(sales_2018 - sales_2017) * 100 / sales_2017 as growth
from cte2
order by growth desc
limit 1;










