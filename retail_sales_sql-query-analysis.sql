-- SQL Retail Sales Analysis --
CREATE DATABASE SQL_Project1_Retail_Sales;

-- Create Table
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
)

SELECT * FROM retail_sales


---
--> DATA CLEANING
---

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
		
---> DATA EXPLORATION

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


--
-- DATA ANALYSIS - Business Key Problems & Solution
--


--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
	WHERE sale_date = '2022-11-05';


--Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
	WHERE 
		category = 'Clothing' 
		AND
		quantity >= 4
		AND
		sale_date BETWEEN '01-11-2022' AND '30-11-2022';


--Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category,
	SUM(total_sale) AS total_sale_per_category 
	FROM retail_sales
	GROUP BY 1;

		
--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
	AVG(age) AS Average_Age
	FROM retail_sales
	WHERE category = 'Beauty'


--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
	WHERE total_sale > 1000


--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category,
	gender,
	COUNT transactions_id AS Total_Transaction
	FROM retail_sales
	group BY category, gender


--Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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


--Q8. Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


--Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;

