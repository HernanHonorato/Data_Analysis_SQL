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

--2) Ejemplo Ranking Window Functions
--Esta consulta selecciona el nombre del producto, el nombre del grupo Y el precio del producto y calcula el ranking de los productos dentro de cada grupo basado en el precio ordenado de forma descendente.

SELECT
	product_name,
	group_name,
	price,
	DENSE_RANK() OVER (PARTITION BY group_name ORDER BY
			price DESC) as ranking
FROM
	products p 
	INNER JOIN product_groups pg ON p.group_id = pg.group_id;

--3) Ejemplo con FIRST_VALUE 
--La siguiente consulta utiliza FIRST_VALUE() para devolver el precio más bajo para cada grupo de productos.

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
