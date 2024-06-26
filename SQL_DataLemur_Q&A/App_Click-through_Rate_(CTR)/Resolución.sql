Consigna: Suponga que tiene una tabla de eventos sobre análisis de aplicaciones. Escriba una consulta para obtener la tasa de clics (% de CTR) por aplicación en 2022. 
Genere los resultados en porcentajes redondeados a 2 decimales. Notas: Para evitar la división de enteros, debe multiplicar la tasa de clics por 100,0, no por 100. 
Porcentaje de tasa de clics = 100,0 * Número de clics / Número de impresiones

Link: https://datalemur.com/questions/sql-app-ctr

WITH click AS(
SELECT app_id, COUNT(event_type) as Number_of_clicks
FROM events
WHERE event_type = 'click' AND
timestamp BETWEEN '2022-01-01' AND '2022-12-31' 

GROUP BY app_id
),
impressions as(
SELECT app_id, COUNT(event_type) as Number_of_impressions
FROM events
WHERE event_type = 'impression' AND
timestamp BETWEEN '2022-01-01' AND '2022-12-31' 
GROUP BY app_id
)
SELECT 
c.app_id,
ROUND((100.0 * c.Number_of_clicks / i.Number_of_impressions :: numeric),2) as ctr
from click c join impressions i on (c.app_id = i.app_id)
