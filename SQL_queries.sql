-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Use the database
USE walmartSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4),
    rating FLOAT(2,1)
);

-- Data cleaning (Initial Check)
SELECT * FROM sales;

-- Add the time_of_day column
ALTER TABLE sales 
ADD COLUMN IF NOT EXISTS time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END;

-- Add day_name column
ALTER TABLE sales 
ADD COLUMN IF NOT EXISTS day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Add month_name column
ALTER TABLE sales 
ADD COLUMN IF NOT EXISTS month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------

-- Number of unique cities
SELECT DISTINCT city FROM sales;

-- Cities and corresponding branches
SELECT DISTINCT city, branch FROM sales;

-- Number of unique product lines
SELECT DISTINCT product_line FROM sales;

-- Most selling product line
SELECT product_line, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_line
ORDER BY total_quantity DESC
LIMIT 1;

-- Total revenue by month
SELECT month_name AS month, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- Month with largest COGS
SELECT month_name AS month, SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC
LIMIT 1;

-- Product line with largest revenue
SELECT product_line, SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 1;

-- City with largest revenue
SELECT city, SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;

-- Product line with highest average VAT
SELECT product_line, AVG(tax_pct) AS avg_tax_pct
FROM sales
GROUP BY product_line
ORDER BY avg_tax_pct DESC
LIMIT 1;

-- Product line performance based on average sales
SELECT product_line,
    CASE
        WHEN AVG(quantity) > (SELECT AVG(quantity) FROM sales) THEN 'Good'
        ELSE 'Bad'
    END AS performance
FROM sales
GROUP BY product_line;

-- Branches with above-average sales
SELECT branch, SUM(quantity) AS total_quantity
FROM sales
GROUP BY branch
HAVING total_quantity > (SELECT AVG(quantity) FROM sales);

-- Most common product line by gender
SELECT gender, product_line, COUNT(*) AS total_count
FROM sales
GROUP BY gender, product_line
ORDER BY total_count DESC;

-- Average rating per product line
SELECT product_line, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- Number of unique customer types
SELECT DISTINCT customer_type FROM sales;

-- Number of unique payment methods
SELECT DISTINCT payment FROM sales;

-- Most common customer type
SELECT customer_type, COUNT(*) AS count
FROM sales
GROUP BY customer_type
ORDER BY count DESC
LIMIT 1;

-- Customer type with highest purchase count
SELECT customer_type, COUNT(*) AS total_count
FROM sales
GROUP BY customer_type;

-- Most common gender of customers
SELECT gender, COUNT(*) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC
LIMIT 1;

-- Gender distribution per branch
SELECT branch, gender, COUNT(*) AS gender_count
FROM sales
GROUP BY branch, gender
ORDER BY gender_count DESC;

-- Average ratings by time of day
SELECT time_of_day, AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Average ratings by time of day for branch 'A'
SELECT time_of_day, AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Best day of the week for ratings
SELECT day_name, AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Day of the week with most sales for branch 'C'
SELECT day_name, COUNT(*) AS total_sales
FROM sales
WHERE branch = 'C'
GROUP BY day_name
ORDER BY total_sales DESC;

-- Number of sales made by time of day on Sundays
SELECT time_of_day, COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Customer type with highest revenue
SELECT customer_type, SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC
LIMIT 1;

-- City with highest average tax percentage
SELECT city, ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city
ORDER BY avg_tax_pct DESC
LIMIT 1;

-- Customer type with highest average VAT
SELECT customer_type, AVG(tax_pct) AS avg_tax_pct
FROM sales
GROUP BY customer_type
ORDER BY avg_tax_pct DESC
LIMIT 1;
