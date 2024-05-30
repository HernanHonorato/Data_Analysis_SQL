![image](https://github.com/HernanHonorato/Data_Analysis_SQL/assets/170138768/fac28f62-e43e-48ae-98d4-3c42caa48eb1)


![Uploading image.png…]()




Y-on-Y Growth Rate [Wayfair SQL Interview Question]

Hello Data Enthusiasts!

Organization:-Wayfair
Level of difficulty: -Hard
Source:-Ankit Bansal sir Live Bootcamp (March 2024) Go from Zero to Hero assignment & DataLemur 🐒 (Ace the SQL & Data Interview)

## Problem Statement:-
Assume you're given a table containing information about Wayfair user transactions for different products. 
..
Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.
..
Desired Output:-
The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.
..

Question Link: https://lnkd.in/dE8_jJ2i
..
Used Advanced Concepts : CTE & Window functions
..
🔍SQL Query:
 
hashtag#The_inner_subquery :
WITH product_yearwise_spending_cte AS 
 (SELECT EXTRACT(year
 FROM transaction_date) AS year,product_id,spend AS current_year_spend, LAG(spend,1) OVER(PARTITION BY product_id
 ORDER BY EXTRACT(year
 FROM transaction_date)ASC ) AS prev_year_spend
 FROM user_transactions )

hashtag#The_outer_query/Main query:
SELECT *,
 ROUND((current_year_spend-prev_year_spend)*100/prev_year_spend,
 2) AS yoy_rate
FROM product_yearwise_spending_cte; 

This is the same question as problem #32 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.
![image](https://github.com/HernanHonorato/Data_Analysis_SQL/assets/170138768/160479d1-77de-4b20-b86f-11b367338578)

user_transactions Table:
Column Name	Type
transaction_id	integer
product_id	integer
spend	decimal
transaction_date	datetime
user_transactions Example Input:
transaction_id	product_id	spend	transaction_date
1341	123424	1500.60	12/31/2019 12:00:00
1423	123424	1000.20	12/31/2020 12:00:00
1623	123424	1246.44	12/31/2021 12:00:00
1322	123424	2145.32	12/31/2022 12:00:00
Example Output:
year	product_id	curr_year_spend	prev_year_spend	yoy_rate
2019	123424	1500.60	NULL	NULL
2020	123424	1000.20	1500.60	-33.35
2021	123424	1246.44	1000.20	24.62
2022	123424	2145.32	1246.44	72.12
Explanation:
Product ID 123424 is analyzed for multiple years: 2019, 2020, 2021, and 2022.

In the year 2020, the current year's spend is 1000.20, and there is no previous year's spend recorded (indicated by an empty cell).
In the year 2021, the current year's spend is 1246.44, and the previous year's spend is 1000.20.
In the year 2022, the current year's spend is 2145.32, and the previous year's spend is 1246.44.
To calculate the year-on-year growth rate, we compare the current year's spend with the previous year's spend.For instance, the spend grew by 24.62% from 2020 to 2021, indicating a positive growth rate.

