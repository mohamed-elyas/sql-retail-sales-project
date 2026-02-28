# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `retail_sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: A Data base named `retail_sales` is created to store the sales data. 
- **Upload data set to database**: The data set structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount as csv.file uploaded to my SQL . all datat tuypes are set to default .no further changes done .



### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **sales made on 2022-11-05**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
```

2. **who bought 4 or more colthings in nov -2022**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    quantiy >= 4
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND category = 'clothing';
```

3. **total sales for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) AS ' total sales ',
    COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category; 
 
```

4. **average age of beauty products consumers**:
```sql
SELECT 
    ROUND(AVG(age)) AS 'average age'
FROM
    retail_sales
WHERE
    category = 'beauty'; 
 
```

5. **transactions for total sales greater than 1000**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000
ORDER BY customer_id ASC; 
 
```

6. **number of transactions for each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(transaction_id) AS 'no of transactions'
FROM
    retail_sales
GROUP BY category , gender
ORDER BY COUNT(transaction_id) DESC;  
```

7. **best selling month in each year**:
```sql
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
```

8. **top 5 customers with highest total sales**:
```sql
SELECT 
    customer_id, SUM(total_sale) AS 'total sales'
FROM
    retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;  
```

9. **number of  unique customers orders for each category**:
```sql
SELECT 
    category, COUNT(DISTINCT customer_id)
FROM
    retail_sales
GROUP BY category; 
```

10. **number of orders during each of the three shifts (morning, afternoon, evening )**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset.

### for contact ,help and support 

- **LinkedIn**: [www.linkedin.com/in/mohamed-osman-68b506360]
  
