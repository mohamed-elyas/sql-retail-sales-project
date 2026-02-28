use retail_sales ; 

		##data exploration and cleaning##


select count(*) from retail_sales ;

select count(distinct customer_id) from retail_sales;

select distinct category from retail_sales ;  

select  * from retail_sales 
where 
ï»¿transactions_id is null or sale_date is null or sale_time is null or
 customer_id is null or gender is null or age is null or category is null or quantiy is null or 
 price_per_unit is null or cogs is null or total_sale is null  ; 
 
 alter table retail_sales 
 rename column ï»¿transactions_id to transaction_id ; 
 
 delete from retail_sales 
 where 
transaction_id  is null or sale_date is null or sale_time is null or
 customer_id is null or gender is null or age is null or category is null or quantiy is null or 
 price_per_unit is null or cogs is null or total_sale is null  ; 
 
									## data analysis & findings ## 

## 1. sales made on 2022-11-05 ## 
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

## 2. who bought 4 or more  colthings in nov -2022 ## 
SELECT 
    *
FROM
    retail_sales
WHERE
    quantiy >= 4
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND category = 'clothing';

## 3. total sales for each category ## 
SELECT 
    category,
    SUM(total_sale) AS ' total sales ',
    COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category; 
 

## 4. average age of beauty products consumers##
SELECT 
    ROUND(AVG(age)) AS 'average age'
FROM
    retail_sales
WHERE
    category = 'beauty'; 


## 5. transactions for total sales greater than 1000 ##  
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000
ORDER BY customer_id ASC; 


#### 6. number of transactions for each gender in each category #### 
SELECT 
    category,
    gender,
    COUNT(transaction_id) AS 'no of transactions'
FROM
    retail_sales
GROUP BY category , gender
ORDER BY COUNT(transaction_id) DESC; 


## 7. avearge sale for each month ##
select * 
from 
(
		select 
		year (sale_date) as year,
		month (sale_date) as month,
		avg(total_sale) as "total sales",
			rank() over(
			partition by year (sale_date) 
			order by avg(total_sale) desc
			) as rnk
        from retail_sales 
		group by 1,2 
) as t1 
        where rnk = 1 ; 
    
    
## 8. top 5 customers with highest total sales##
SELECT 
    customer_id, SUM(total_sale) AS 'total sales'
FROM
    retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;  


## 9. number of orders for each category ## 
SELECT 
    category, COUNT(DISTINCT customer_id)
FROM
    retail_sales
GROUP BY category; 


## 10. number of orders during each of the three shifts (morning, afternoon, evening ) ## 
with hourly_sale
as
(
select *,
	case 
        when hour(sale_time) <12 then 'morning'
        when hour(sale_time) between 12 and 17 then 'aftenoon'
        else 'evening' 
	end as shift
from retail_sales 
)
select 
shift ,
count(*) as total_orders
from hourly_sale
group by shift ;


												## END OF PROJECT ##