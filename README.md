**# Walmart-Sales-Data-Analysis**
This project explores the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aim is to study how sales strategies can be improved and optimized. 
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

Challenge: "In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact."

**#Purposes Of The Project**
The major aim of this project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

About Data
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from  three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

**#Analysis List**
1. Product Analysis: Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis: This analysis aims to answer the question of the sales trends of products. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.

3. Customer Analysis: This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.

**#Approach Used**

1. Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
( There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.)

2. Feature Engineering: This will help use generate some new columns from existing ones.
	1. Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
  	2. Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
  	3. Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

3. Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the aim of this project.

4. Conclusion
