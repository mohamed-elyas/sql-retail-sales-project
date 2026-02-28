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
select * from retail_sales 
where sale_date = '2022-11-05' ;

## 2. who bought 4 or more  colthings in nov -2022 ## 
SELECT *
FROM retail_sales
WHERE quantiy >= 4
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND category = 'clothing';

## 3. total sales for each category ## 
select category, 
sum(total_sale) as " total sales " ,
COUNT(*) as total_orders 
from retail_sales 
group by category ; 
 

## 4. average age of beauty products consumers##
select round(avg(age )) as "average age"
from retail_sales
where category = 'beauty' ; 


## 5. transactions for total sales greater than 1000 ##  
select * 
from retail_sales 
where total_sale > 1000 
order by customer_id asc ; 


#### 6. number of transactions for each gender in each category #### 
select category , gender ,count(transaction_id) as "no of transactions"
from retail_sales 
group by category , gender 
order by count(transaction_id) desc; 


## 7. avearge sale for each month##
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
select customer_id , sum(total_sale) as "total sales"
from retail_sales 
group by customer_id
order by sum(total_sale) desc 
limit  5 ;  


## 9. number of orders for each category ## 
select category , count(distinct customer_id) 
from retail_sales  
group by category ; 


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