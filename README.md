# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `SQL_Project1_Retail_Sales`

## Objectives

1. **Set up a retail sales database**
2. **Data Cleaning**
3. **Exploratory Data Analysis (EDA)**
4. **Business Analysis**

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_Project1_Retail_Sales`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data.  
  Columns - transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS) and total sale amount.

```sql
CREATE DATABASE SQL_Project1_Retail_Sales;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(10),
	age	INT,
	category VARCHAR(15),	
	quantiy	INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- Count the total number of records in the dataset.
- Count how many unique customers are in the dataset.
- Find Start Date & End Date
- Identify all unique product categories in the dataset.
- Check for any null values in the dataset and delete records with missing data.

```sql
-- Count Total no. of rows
SELECT
	COUNT(*)
FROM retail_sales;

-- Count Total no. of Customers
SELECT
	COUNT(DISTINCT(customer_id)) AS Total_Customer
FROM retail_sales;

-- Find Start Date & End Date
SELECT
	MIN(sale_date) AS Start_Date,
	MAX(sale_date) AS End_Date
FROM retail_sales;

-- Find total no. and names of Category
SELECT 
	DISTINCT category AS Distinct_Category
FROM retail_sales;

```

```sql
-- Finding 'null' Values
SELECT * FROM retail_sales
	WHERE 	
		transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id IS NULL
		OR
		gender IS NULL
		OR
		age IS NULL
		OR
		category IS NULL
		OR
		quantity IS NULL
		OR	
		price_per_unit IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL;

-- Deleting 'null' values data

DELETE FROM retail_sales
	WHERE
		transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id IS NULL
		OR
		gender IS NULL
		OR
		age IS NULL
		OR
		category IS NULL
		OR
		quantity IS NULL
		OR	
		price_per_unit IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
	WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
	WHERE 
		category = 'Clothing' 
		AND
		quantity >= 4
		AND
		sale_date BETWEEN '01-11-2022' AND '30-11-2022';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	category,
	SUM(total_sale) AS total_sale_per_category 
FROM retail_sales
GROUP BY 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM retail_sales
	WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
	category,
	gender,
	COUNT(transactions_id) AS Total_Transaction
	FROM retail_sales
	group BY category, gender
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **Time-of-Day Sales Behavior**: Sales were highest during the Afternoon shift, suggesting optimal promotional timing.
- **Top Performing Categories**: Clothing consistently topped in both sales volume and revenue contribution.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Shift-Based Sales Analysis**: Sales broken down by time-of-day shifts (Morning, Afternoon, Evening) to understand customer shopping habits.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project not only demonstrates fundamental SQL techniques but also simulates how data analysts solve real-world business problems using structured queries. From cleaning data and identifying sales patterns to customer profiling and performance segmentation, the project provides a practical learning experience in SQL-based analytics.   
These insights can help businesses:  
    - Optimize inventory for high-demand categories  
    - Time promotions for peak buying hours  
    - Segment customers for targeted marketing  
    - Track product/category-level performance over time  


