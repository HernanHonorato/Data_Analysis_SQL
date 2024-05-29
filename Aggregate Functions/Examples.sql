--1) Example of Aggregate Window Functions

--"The following query returns the product name, the price, the product group name, along with the average prices of each product group."
SELECT
	product_name,
	price,
	group_name,
	ROUND(AVG(price) OVER (PARTITION BY group_name),2) AS precio_promedio
FROM
	products p 
	INNER JOIN product_groups pg ON p.group_id = pg.group_id;

--2) Example of Ranking Window Functions
--"This query selects the product name, the group name, and the product price, and calculates the ranking of the products within each group based on the price ordered in descending order."
SELECT
	product_name,
	group_name,
	price,
	DENSE_RANK() OVER (PARTITION BY group_name ORDER BY
			price DESC) as ranking
FROM
	products p 
	INNER JOIN product_groups pg ON p.group_id = pg.group_id;

--3) Example with FIRST_VALUE 
--"The following query uses FIRST_VALUE() to return the lowest price for each product group."

SELECT
	product_name,
	group_name,
	price,
	FIRST_VALUE(price) OVER (
		PARTITION BY group_name ORDER BY 
	        price) AS menor_precio_por_grupo
FROM
	products p 
	INNER JOIN product_groups pg ON p.group_id = pg.group_id;
